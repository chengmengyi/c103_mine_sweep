import 'dart:math';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_play_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_point_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_card_game/ms_p2_card_game_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_play_fail/ms_p2_play_fail_has_money/ms_p2_play_fail_has_money_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_play_fail/ms_p2_play_fail_no_money/ms_p2_play_fail_no_money_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_play_win/ms_p2_play_win_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_wheel/ms_p2_wheel_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_cash_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter/material.dart';

class MsP2PlayUtils {
  var canClick=false,currentHandsNum=0,hasWildCard=false;
  List<List<MsP2CardBean>> cardList=[];
  MsP2PointBean? p1pointBean;
  GlobalKey? _pointCardGlobalKey;

  updateHandsNum(int addNum){
    currentHandsNum+=addNum;
  }

  initCardList(List<List<MsP2CardBean>> list){
    cardList.clear();
    cardList.addAll(list);
    setRandomMoneyCards(cardList);
  }

  //初始化顶部的卡牌数值和其他卡牌是否被覆盖
  initTopCardNumAndCovered({required Function() initCallback}){
    _initCardNumByList();
    _checkAllCovered();
    initCallback.call();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _turnOverCard();
      setBottomCenterCard(reset: true);
    });
  }

  iniPointCardGlobalKey(GlobalKey pointCardGlobalKey){
    _pointCardGlobalKey=pointCardGlobalKey;
  }

  //处理龙卷风数据
  handleTornadoData({
    required Function() refreshCallback,
    required Function() resetPlayGame,
})async{
    canClick=false;
    MsVoiceUtils.instance.playMusic(MusicType.feng1);
    var cardsNum=0;
    for (var value in cardList) {
      for (var value1 in value) {
        if(!value1.isCoveredCard&&value1.canShow&&!value1.isMoneyCard){
          cardsNum++;
          value1.canShow=false;
        }
      }
    }
    refreshCallback.call();
    await Future.delayed(Duration(milliseconds: 500));
    P2UserInfoUtils.instance.updateCoinsNum(cardsNum*MsP2ValueUtils.instance.getRemoveCardReward());
    //全部完了
    if(_checkAllPlayFinish()){
      _allPlayFinish(refreshCallback: refreshCallback,resetPlayGame: resetPlayGame);
    }else{  //还有牌可以玩
      _checkAllCovered();
      refreshCallback.call();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _turnOverCard();
        canClick=true;
      });
    }
  }

  clickCard({
    required MsP2CardBean bean,
    required Function() refreshCallback,
    required Function() resetPlay,
    Function()? fromStep2Callback,
  }){
    if(!canClick||bean.isCoveredCard||!bean.canShow||null==_pointCardGlobalKey){
      return;
    }
    if(bean.isMoneyCard){
      bean.canShow=false;
      refreshCallback.call();
      MsRouterUtils.instance.showDialog(
        child: GetCoinsDialog(
          addNum: MsP2ValueUtils.instance.getMoneyCardReward(),
          success: (){
            fromStep2Callback?.call();
            P2UserInfoUtils.instance.updateWheelPro();
            var showWheelDialog = P2UserInfoUtils.instance.checkShowWheelDialog();
            if(showWheelDialog){
              _showCardGameOrWheelDialog(refreshCallback,resetPlay,bean);
            }else{
              _checkPlayFinishOrHasCardPlay(refreshCallback,resetPlay,bean);
            }
          },
        ),
      );
      return;
    }
    if(_checkPlayFail()){
      _showFailDialog(resetPlay);
      return;
    }
    if(hasWildCard){
      hasWildCard=false;
      MsP2CashUtils.instance.updateCashTask(CashTaskName.task2Use20Wild);
      MsVoiceUtils.instance.playMusic(MusicType.wild);
      _checkClickResult(bean: bean, refreshCallback: refreshCallback,resetPlayGame: resetPlay);
      return;
    }
    var twoCardsDiff1 = _checkTwoCardsDiff1(p1pointBean?.cardText??"",bean.cardText);
    if(!twoCardsDiff1){
      _getPlayTips();
      return;
    }
    MsVoiceUtils.instance.playMusic(MusicType.xiaochu);
    _checkClickResult(bean: bean, refreshCallback: refreshCallback,resetPlayGame: resetPlay);
  }

  _checkClickResult({
    required MsP2CardBean bean,
    required Function() refreshCallback,
    required Function() resetPlayGame,
  })async{
    canClick=false;
    bean.canShow=false;
    refreshCallback.call();
    await _startCardMoveAnimator(bean);
    P2UserInfoUtils.instance.updateCoinsNum(MsP2ValueUtils.instance.getRemoveCardReward());
    P2UserInfoUtils.instance.updateWheelPro();
    var showWheelDialog = P2UserInfoUtils.instance.checkShowWheelDialog();
    if(showWheelDialog){
      _showCardGameOrWheelDialog(refreshCallback,resetPlayGame,bean);
    }else{
      _checkPlayFinishOrHasCardPlay(refreshCallback,resetPlayGame,bean);
    }
  }

  _checkPlayFinishOrHasCardPlay(Function() refreshCallback, Function() resetPlayGame, MsP2CardBean bean,){
    P2UserInfoUtils.instance.updateLevel12PlayCardNum();
    //全部完了
    if(_checkAllPlayFinish()){
      _allPlayFinish(refreshCallback: refreshCallback,resetPlayGame: resetPlayGame);
    }else{  //还有牌可以玩
      _hasCardCanPlay(bean: bean, refreshCallback: refreshCallback);
    }
  }

  //全部完了
  _allPlayFinish({
    required Function() refreshCallback,
    required Function() resetPlayGame,
  })async{
    if(currentHandsNum>0){
      var handsNum=currentHandsNum;
      MsEventUtils.instance.sendMsg(code: MsP2EventCode.handleHandsCard);
      await Future.delayed(Duration(milliseconds: handsNum*400));
      _showPlayWinDialog(handsNum*MsP2ValueUtils.instance.getRemoveCardReward(),resetPlayGame);
    }else{
      _showPlayWinDialog(0,resetPlayGame);
    }
  }

  _showPlayWinDialog(double reward,Function() resetPlayGame){
    var diamondAddNum=MsP2ValueUtils.instance.getDiamondReward();
    var routerName = P2UserInfoUtils.instance.updateLevel(diamondAddNum);
    MsVoiceUtils.instance.playMusic(MusicType.playwin);
    MsP2CashUtils.instance.updateCashTask(CashTaskName.task1Pass5);
    MsRouterUtils.instance.showDialog(
      child: MsP2PlayWinDialog(
        diamondAddNum: diamondAddNum,
        rewards: reward,
        clickNext: (){
          if(routerName.isEmpty){
            _resetPlay(resetPlayGame);
          }else{
            MsRouterUtils.instance.offNamed(routersName: routerName);
          }
        },
        clickHome: (){
          MsRouterUtils.instance.back();
        },
      ),
    );
  }

  //显示翻卡游戏或转盘弹窗
  _showCardGameOrWheelDialog(Function() refreshCallback, Function() resetPlayGame, MsP2CardBean bean,){
    if(p2LastShowWheel.getData()){
      MsRouterUtils.instance.showDialog(
        child: MsP2CardGameDialog(
          dismissDialog: (addNum){
            _showCardGameOrWheelGetCoinsDialog(addNum,refreshCallback,resetPlayGame,bean);
          },
        ),
      );
    }else{
      MsRouterUtils.instance.showDialog(
        child: MsP2WheelDialog(
          dismissDialog: (addNum){
            _showCardGameOrWheelGetCoinsDialog(addNum,refreshCallback,resetPlayGame,bean);
          },
        ),
      );
    }
  }

  //翻卡游戏或转盘弹窗结束后显示获得弹窗
  _showCardGameOrWheelGetCoinsDialog(addNum,Function() refreshCallback, Function() resetPlayGame, MsP2CardBean bean,){
    P2UserInfoUtils.instance.updateLastWheelShowType();
    if(addNum<=0){
      _checkPlayFinishOrHasCardPlay(refreshCallback,resetPlayGame,bean);
      return;
    }
    MsRouterUtils.instance.showDialog(
      child: GetCoinsDialog(
        addNum: addNum,
        success: (){
          _checkPlayFinishOrHasCardPlay(refreshCallback,resetPlayGame,bean);
        },
      ),
    );
  }

  //还有牌可以玩
  _hasCardCanPlay({
    required MsP2CardBean bean,
    required Function() refreshCallback,
  }){
    _checkAllCovered();
    refreshCallback.call();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _turnOverCard();
    });
    canClick=true;
  }

  _resetPlay(Function() resetPlay){
    cardList.clear();
    canClick=true;
    currentHandsNum=0;
    p1pointBean=null;
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.resetBottomInfo);
    resetPlay.call();
  }

  bool _checkAllPlayFinish(){
    for (var value in cardList) {
      for (var value1 in value) {
        if(value1.canShow){
          return false;
        }
      }
    }
    return true;
  }

  //开始卡牌移动动画
  _startCardMoveAnimator(MsP2CardBean bean)async{
    var cardRenderBox = bean.globalKey.currentContext!.findRenderObject() as RenderBox;
    var cardOffset = cardRenderBox.localToGlobal(Offset.zero);
    var pointRenderBox = _pointCardGlobalKey?.currentContext!.findRenderObject() as RenderBox;
    var pointOffset = pointRenderBox.localToGlobal(Offset.zero);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.cardMoveAnimator,anyValue: {"cardOffset":cardOffset,"pointOffset":pointOffset,"bean":bean});
    await Future.delayed(Duration(milliseconds: 300));
    p1pointBean=MsP2PointBean(cardText: bean.cardText, cardTypeEnum: bean.cardType);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.refreshPointCard);
  }

  _showFailDialog(Function() resetPlay){
    MsVoiceUtils.instance.playMusic(MusicType.playfail);
    if(p2CoinsNum.getData()>=2000){
      MsRouterUtils.instance.showDialog(
        child: MsP2PlayFailHasMoneyDialog(
          clickGetCards: (){
            updateHandsNum(5);
            MsEventUtils.instance.sendMsg(code: MsP2EventCode.addHandCardsNum);
          },
          clickReplay: (){
            _resetPlay(resetPlay);
          },
          clickHome: (){
            MsRouterUtils.instance.back();
          },
        ),
      );
    }else{
      MsRouterUtils.instance.showDialog(
        child: MsP2PlayFailNoMoneyDialog(
          clickHome: (){
            MsRouterUtils.instance.back();
          },
          clickReplay: (){
            _resetPlay(resetPlay);
          },
        ),
      );
    }
  }

  bool _checkPlayFail(){
    if(currentHandsNum>0||hasWildCard){
      return false;
    }
    List<MsP2CardBean> list=[];
    for (var value in cardList) {
      for (var value1 in value) {
        if(!value1.isCoveredCard&&value1.canShow&&value1.isMoneyCard){
          return false;
        }
        if(!value1.isCoveredCard&&value1.canShow){
          list.add(value1);
        }
      }
    }

    for (var value2 in list) {
      var twoCardsDiff1 = _checkTwoCardsDiff1(p1pointBean?.cardText??"",value2.cardText);
      if(twoCardsDiff1){
         return false;
      }
    }
    return true;
  }

  //设置底部的指示牌
  setBottomCenterCard({bool reset=false}){
    var list = cardList.expand((row) => row).where((c) => !c.isCoveredCard&&c.canShow&&c.cardText.isNotEmpty).toList();
    if(list.isEmpty){
      return;
    }
    var cardText = _getPointCardNum(list);
    p1pointBean=MsP2PointBean(cardText: cardText, cardTypeEnum: CardTypeEnum.values.random());
    if(reset){
      MsEventUtils.instance.sendMsg(code: MsP2EventCode.pointCardTurnOver);
    }
  }

  String _getPointCardNum(List<MsP2CardBean> list){
    Set<int> allValues = {};
    for (var card in list) {
      allValues.addAll(_cardTextToValues(card.cardText));
    }
    final List<int> cardValues = List.generate(13, (i) => i + 1);
    final random = Random();

    if (_getPointCardProbability()) {
      // 相邻 ±1 的所有可能值
      Set<int> adjacentValues = {};
      for (int val in allValues) {
        adjacentValues.add(val - 1);
        adjacentValues.add(val + 1);
      }

      // 合法范围 1~13（可以再扩展到 14=A）
      List<int> valid = adjacentValues.where((v) => v >= 1 && v <= 14).toList();

      if (valid.isNotEmpty) {
        int selected = valid[random.nextInt(valid.length)];
        return _cardValueToText(selected);
      } else {
        // fallback
        int selected = cardValues[random.nextInt(cardValues.length)];
        return _cardValueToText(selected);
      }
    } else {
      // 随机一个与所有值都不相邻的
      List<int> nonAdjacentValues = cardValues.where((v) {
        for (int existing in allValues) {
          if ((v - existing).abs() == 1) return false;
          // 额外处理 A=1 和 A=14 相邻情况
          if ((existing == 1 && v == 13) || (existing == 13 && v == 1)) return false;
        }
        return true;
      }).toList();

      if (nonAdjacentValues.isNotEmpty) {
        int selected = nonAdjacentValues[random.nextInt(nonAdjacentValues.length)];
        return _cardValueToText(selected);
      } else {
        // fallback
        int selected = cardValues[random.nextInt(cardValues.length)];
        return _cardValueToText(selected);
      }
    }
  }

  //翻开卡牌
  _turnOverCard(){
    var list = cardList
        .expand((row) => row)
        .where((card) => !card.isCoveredCard&&card.canShow)
        .toList();
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.turnOverCard,anyValue: list);
  }

  //初始化卡片数值
  _initCardNumByList() {
    final List<int> cardValues = List.generate(13, (i) => i + 1);
    final random = Random();

    List<int> assignedValues = [];

    // 构建遍历顺序：行从后往前，行内从左到右
    List<MsP2CardBean> flatList = [];
    for (int i = cardList.length - 1; i >= 0; i--) {
      flatList.addAll(cardList[i]); // 不做任何过滤
    }

    for (int i = 0; i < flatList.length; i++) {
      MsP2CardBean current = flatList[i];
      int selected;

      if (i == 0) {
        // 第一个随机赋值
        selected = cardValues[random.nextInt(cardValues.length)];
      } else {
        if (_getCardProbability()) {
          //  满足条件：从已赋值中取相邻 ±1 的值
          Set<int> adjacentCandidates = {};
          for (int v in assignedValues) {
            adjacentCandidates.add(v - 1);
            adjacentCandidates.add(v + 1);
          }

          // 合法范围 1~14
          adjacentCandidates = adjacentCandidates
              .where((v) => v >= 1 && v <= 14)
              .toSet();

          // 去除已使用的值
          List<int> available = adjacentCandidates
              .difference(assignedValues.toSet())
              .toList();

          if (available.isNotEmpty) {
            selected = available[random.nextInt(available.length)];
          } else if (adjacentCandidates.isNotEmpty) {
            selected =
                adjacentCandidates.elementAt(random.nextInt(adjacentCandidates.length));
          } else {
            selected = cardValues[random.nextInt(cardValues.length)];
          }
        } else {
          //  不满足条件：选一个与已赋值的牌都“不相邻”的值
          List<int> nonAdjacentOptions = cardValues.where((v) {
            for (int assigned in assignedValues) {
              if ((v - assigned).abs() == 1) return false;
            }
            return true;
          }).toList();

          if (nonAdjacentOptions.isNotEmpty) {
            selected = nonAdjacentOptions[random.nextInt(nonAdjacentOptions.length)];
          } else {
            // 实在找不到就随便来一个
            selected = cardValues[random.nextInt(cardValues.length)];
          }
        }
      }

      assignedValues.add(selected);
      current.cardText = _cardValueToText(selected);
      current.cardType = CardTypeEnum.values.random();
    }
  }

  bool _checkTwoCardsDiff1(String card1, String card2){
    final valueMap = {
      'A': [1, 14],
      '2': [2],
      '3': [3],
      '4': [4],
      '5': [5],
      '6': [6],
      '7': [7],
      '8': [8],
      '9': [9],
      '10': [10],
      'J': [11],
      'Q': [12],
      'K': [13],
    };
    final values1 = valueMap[card1] ?? [];
    final values2 = valueMap[card2] ?? [];

    for (var v1 in values1) {
      for (var v2 in values2) {
        if ((v1 - v2).abs() == 1) return true;
      }
    }
    return false;
  }

  _getPlayTips(){
    var card=p1pointBean?.cardText;
    var list = ['A', '2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K'];
    var indexWhere = list.indexWhere((element) => element==card);
    var tips="";
    if(indexWhere<0){
      tips = "";
    }else if(indexWhere==0){
      tips = "2 or K";
    }else if(indexWhere==list.length-1){
      tips = "Q or A";
    }else{
      tips = "${list[indexWhere-1]} or ${list[indexWhere+1]}";
    }

    showToast("Your current hand is $card, you can only eliminate $tips");
  }

  String _cardValueToText(int value) {
    if (value == 1 || value == 14) return "A";
    if (value == 11) return "J";
    if (value == 12) return "Q";
    if (value == 13) return "K";
    return value.toString();
  }

  List<int> _cardTextToValues(String cardText) {
    switch (cardText) {
      case "A":
        return [1, 14];
      case "J":
        return [11];
      case "Q":
        return [12];
      case "K":
        return [13];
      default:
        return [int.tryParse(cardText) ?? -1];
    }
  }

  //校验是否被覆盖
  _checkAllCovered() {
    final list = cardList.expand((row) => row).toList();
    for (int i = 0; i < cardList.length; i++) {
      for (int j = 0; j < cardList[i].length; j++) {
        var bean = cardList[i][j];
        var isCovered = _isCoveredByHigher(globalKey: bean.globalKey, list: list,);
        bean.isCoveredCard=isCovered;
      }
    }
  }

  bool _isCoveredByHigher({
    required GlobalKey globalKey,
    required List<MsP2CardBean> list,
  }) {
    final selfCorners = _getPoint(globalKey);
    if (selfCorners.isEmpty){
      return false;
    }

    final selfRect = _getRect(selfCorners);
    final indexWhere = list.indexWhere((value)=>value.globalKey==globalKey);
    if (indexWhere == -1) {
      return false;
    }

    for (int i = indexWhere + 1; i < list.length; i++) {
      var childBean = list[i];
      if (!childBean.canShow) {
        continue;
      }
      final otherCorners = _getPoint(childBean.globalKey);
      if (otherCorners.isEmpty) {
        continue;
      }

      final otherRect = _getRect(otherCorners);
      if (selfRect.overlaps(otherRect)) {
        return true;
      }
    }
    return false;
  }

  List<Offset> _getPoint(GlobalKey key) {
    try{
      var renderBox = key.currentContext!.findRenderObject() as RenderBox;
      final size = renderBox.size;
      final transform = renderBox.getTransformTo(null);

      final points = [
        Offset.zero,
        Offset(size.width, 0),
        Offset(size.width, size.height),
        Offset(0, size.height),
      ];
      return points.map((p) => MatrixUtils.transformPoint(transform, p)).toList();
    }catch(e){
      return [];
    }
  }

  Rect _getRect(List<Offset> points) => Rect.fromLTRB(
    points.map((e) => e.dx).reduce(min),
    points.map((e) => e.dy).reduce(min),
    points.map((e) => e.dx).reduce(max),
    points.map((e) => e.dy).reduce(max),
  );

  //获取卡牌的满足概率
  bool _getCardProbability(){
    var currentLevelNum = P2UserInfoUtils.instance.getCurrentLevelNum();
    if(currentLevelNum<=10){
      return Random().nextInt(100)<70;
    }else if(currentLevelNum<=20){
      return Random().nextInt(100)<65;
    }else if(currentLevelNum<=30){
      return Random().nextInt(100)<55;
    }else if(currentLevelNum<=40){
      return Random().nextInt(100)<40;
    }else if(currentLevelNum<=50){
      return Random().nextInt(100)<30;
    }
    return Random().nextInt(100)<30;
  }

  bool _getPointCardProbability(){
    var currentLevelNum = P2UserInfoUtils.instance.getCurrentLevelNum();
    if(currentLevelNum<=10){
      return Random().nextInt(100)<70;
    }else if(currentLevelNum<=20){
      return Random().nextInt(100)<60;
    }else if(currentLevelNum<=30){
      return Random().nextInt(100)<50;
    }else if(currentLevelNum<=40){
      return Random().nextInt(100)<40;
    }else if(currentLevelNum<=50){
      return Random().nextInt(100)<30;
    }
    return Random().nextInt(100)<30;
  }

  //随机设置其中3个是现金卡
  setRandomMoneyCards(List<List<MsP2CardBean>> cardGrid) {
    final rand = Random();
    final flatList = cardGrid.expand((row) => row).where((card) => !card.isTopCard).toList();
    if (flatList.length <= 3) {
      for (var card in flatList) {
        card.isMoneyCard = true;
      }
      return;
    }
    flatList.shuffle(rand);
    for (int i = 0; i < 3; i++) {
      flatList[i].isMoneyCard = true;
    }
  }
}