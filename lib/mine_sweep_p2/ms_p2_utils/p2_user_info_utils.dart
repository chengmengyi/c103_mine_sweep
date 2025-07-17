import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_card_game/ms_p2_card_game_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_good_comment_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:decimal/decimal.dart';

class P2UserInfoUtils{
  static final P2UserInfoUtils _utils = P2UserInfoUtils();
  static P2UserInfoUtils get instance => _utils;

  updateWheelPro(){
    p2WheelPro.saveData(p2WheelPro.getData()+1);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateWheelPro);
  }

  bool checkShowWheelDialog()=>p2WheelPro.getData()>=5;

  updateLastWheelShowType(){
    p2WheelPro.saveData(0);
    p2LastShowWheel.saveData(!p2LastShowWheel.getData());
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateWheelPro);
  }

  int getCurrentLevelNum(){
    var level = p2LevelNum.getData();
    int offset = (level - 1) % 80;
    if (offset < 10) {
      return offset + 1;
    } else {
      return offset + 1;
    }
  }

  String updateLevel(int diamondAddNum){
    updateDiamond(diamondAddNum);
    var nextLevel = _checkToNextLevelPage();
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateLevel);
    if(nextLevel>=0){
      return _getRouterNameByLevel(nextLevel);
    }else{
      return "";
    }
  }

  updateDiamond(int addNum){
    p2DiamondNum.saveData(p2DiamondNum.getData()+addNum);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateDiamond);
  }

  updateLevel12PlayCardNum(){
    if(p2LevelNum.getData()==12){
      p2Level12PlayCardNum.saveData(p2Level12PlayCardNum.getData()+1);
      if(p2Level12PlayCardNum.getData()==4){
        MsEventUtils.instance.sendMsg(code: MsP2EventCode.showTomadoGuide);
      }
    }
  }

  int _checkToNextLevelPage(){
    var currentLevel = p2LevelNum.getData();
    int nextLevel = currentLevel + 1;
    int currentStage = (currentLevel - 1) ~/ 10;
    int nextStage = (nextLevel - 1) ~/ 10;
    p2LevelNum.saveData(nextLevel);
    var isNext = currentStage != nextStage;
    if(isNext){
      return nextLevel;
    }else{
      return -1;
    }
  }


  String _getRouterNameByLevel(int nextLevel){
    var i = nextLevel%80;
    if(i<=10){
      return MsP2RoutersName.play10;
    }else if(i<=20){
      return MsP2RoutersName.play20;
    }else if(i<=30){
      return MsP2RoutersName.play30;
    }else if(i<=40){
      return MsP2RoutersName.play40;
    }else if(i<=50){
      return MsP2RoutersName.play50;
    }else if(i<=60){
      return MsP2RoutersName.play60;
    }else if(i<=70){
      return MsP2RoutersName.play70;
    }else if(i<=80){
      return MsP2RoutersName.play80;
    }
    return "";
  }

  updateCoinsNum(add){
    if(add==0){
      return;
    }
    if(add>0&&p2FirstGetCoins.getData()){
      p2FirstGetCoins.saveData(false);
      MsP2GoodCommentUtils.instance.checkShowGoodGuide();
    }
    var current = p2CoinsNum.getData();
    var result = (Decimal.parse("$current")+Decimal.parse("$add")).toDouble();
    p2CoinsNum.saveData(result);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateCoins,anyValue: add);
  }
}