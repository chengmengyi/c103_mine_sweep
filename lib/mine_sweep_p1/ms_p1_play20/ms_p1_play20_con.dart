import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_bean/ms_p1_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_play_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter/material.dart';

class MsP1Play20Con extends MsBaseCon{
  MsP1PlayUtils p1playUtils=MsP1PlayUtils();


  @override
  void onReady() {
    super.onReady();
    _initCard();
  }

  clickCard(MsP1CardBean bean){
    p1playUtils.clickCard(
      bean: bean,
      refreshCallback: (){
        update(["list"]);
      },
      resetPlay: (){
        _initCard();
      }
    );
  }

  clickHome(){
    MsRouterUtils.instance.back();
  }

  clickResume(){
 
  }

  _initCard()async{
    MsVoiceUtils.instance.playMusic(MusicType.fapai);
    List<List<MsP1CardBean>> cardList = [];
    var tag = 0;
    while (cardList.length < 3) {
      if (cardList.isEmpty) {
        List<MsP1CardBean> list = [];
        while (list.length < 4) {
          list.add(
            MsP1CardBean(
              tag: tag,
              cardText: "",
              isTopCard: false,
              isCoveredCard: false,
              canShow: false,
              cardType: CardTypeEnum.values.random(),
              globalKey: GlobalKey(),
            )
          );
          tag++;
        }
        cardList.add(list);
      } else if (cardList.length == 1) {
        List<MsP1CardBean> list = [];
        while (list.length < 4) {
          list.add(
              MsP1CardBean(
                tag: tag,
                cardText: "",
                isTopCard: false,
                isCoveredCard: false,
                canShow: false,
                cardType: CardTypeEnum.values.random(),
                globalKey: GlobalKey(),
              )
          );
          tag++;
        }
        cardList.add(list);
      }else if (cardList.length == 2) {
        List<MsP1CardBean> list = [];
        while (list.length < 3) {
          list.add(
              MsP1CardBean(
                tag: tag,
                cardText: "",
                isTopCard: true,
                isCoveredCard: false,
                canShow: false,
                cardType: CardTypeEnum.values.random(),
                globalKey: GlobalKey(),
              )
          );
          tag++;
        }
        cardList.add(list);
      }
    }
    p1playUtils.initCardList(cardList);
    await _delayShowList();
    MsEventUtils.instance.sendMsg(code: MsP1EventCode.startInitHandsCard);
    p1playUtils.initTopCardNumAndCovered(
      initCallback: (){
        update(["list"]);
      },
    );
  }

  _delayShowList()async{
    for(var index=0;index<6;index++){
      if(pageClosed){
        break;
      }
      switch(index){
        case 0:
          _startShowList(0, 0, 2);
          break;
        case 1:
          _startShowList(0, 2, 4);
          break;
        case 2:
          _startShowList(1, 0, 2);
          break;
        case 3:
          _startShowList(1, 2, 4);
          break;
        case 4:
          _startShowList(2, 0, 1);
          break;
        case 5:
          _startShowList(2, 1, 3);
          break;
      }
      update(["list"]);
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  _startShowList(int listIndex,int startIndex,int endIndex){
    var list = p1playUtils.cardList[listIndex];
    for(int i=startIndex;i<endIndex;i++){
      list[i].canShow=true;
    }
  }


  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP1EventCode.startTornadoAnimator:
        p1playUtils.handleTornadoData(
          refreshCallback: (){
            update(["list"]);
          },
          resetPlayGame: (){
            _initCard();
          },
        );
        break;
    }
  }
}