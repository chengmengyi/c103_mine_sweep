import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_play_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/ms_p2_guide_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_play_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter/material.dart';

import '../../mine_sweep_storage/p2/p2_storage.dart';
import '../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2Play60Con extends MsBaseCon{
  MsP2PlayUtils p1playUtils=MsP2PlayUtils();
  GlobalKey topMoneyGlobalKey=GlobalKey();
  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.game_page,params: {"level":p2LevelNum.getData()});
  }
  @override
  void onReady() {
    super.onReady();
    _initCard();
  }

  clickCard(MsP2CardBean bean,{Function()? fromStep2Callback}){
    p1playUtils.clickCard(
      bean: bean,
      refreshCallback: (){
        update(["list"]);
        _showMoneyCardGuide();
      },
      resetPlay: (){
        _initCard();
      },
      fromStep2Callback: fromStep2Callback,
    );
  }

  clickHome(){
    MsRouterUtils.instance.back();
  }

  clickResume(){
 
  }

  _initCard()async{
    MsVoiceUtils.instance.playMusic(MusicType.fapai);
    List<List<MsP2CardBean>> cardList = [];
    var tag = 0;
    while (cardList.length < 3) {
      if (cardList.isEmpty) {
        List<MsP2CardBean> list = [];
        while (list.length < 7) {
          list.add(
            MsP2CardBean(
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
      }  else if (cardList.length == 1) {
        List<MsP2CardBean> list = [];
        while (list.length < 13) {
          list.add(
              MsP2CardBean(
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
        List<MsP2CardBean> list = [];
        while (list.length < 2) {
          list.add(
              MsP2CardBean(
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
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.startInitHandsCard);
    p1playUtils.initTopCardNumAndCovered(
      initCallback: (){
        update(["list"]);
      },
    );
  }

  _delayShowList()async{
    for(var index=0;index<8;index++){
      if(pageClosed){
        break;
      }
      switch(index){
        case 0:
          _startShowList(0, 0, 2);
          break;
        case 1:
          _startShowList(0, 2, 6);
          break;
        case 2:
          _startShowList(0, 6, 7);
          break;
        case 3:
          _startShowList(1, 0, 4);
          break;
        case 4:
          _startShowList(1, 4, 10);
          break;
        case 5:
          _startShowList(1, 10, 12);
          break;
        case 6:
          _startShowList(1, 12, 13);
          break;
        case 7:
          _startShowList(2, 0, 2);
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
      case MsP2EventCode.startTornadoAnimator:
        p1playUtils.handleTornadoData(
          refreshCallback: (){
            update(["list"]);
            _showMoneyCardGuide();
          },
          resetPlayGame: (){
            _initCard();
          },
        );
        break;
    }
  }

  _showMoneyCardGuide(){
    MsP2GuideUtils.instance.showStep2Guide(
      context: context,
      cardList: p1playUtils.cardList,
      dismissCallback: (bean){
        clickCard(
          bean,
          fromStep2Callback: (){
            MsP2GuideUtils.instance.showStep4Guide(context, topMoneyGlobalKey);
          },
        );
      },
    );
  }
}