import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_play_win/ms_p1_play_win_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_card_game/ms_p2_card_game_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_good_comment/ms_p2_good_comment_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_play_fail/ms_p2_play_fail_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_reach_cash/ms_p2_reach_cash_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_wheel/ms_p2_wheel_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/ms_p2_guide_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_cash_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_good_comment_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_local_notification_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeChildCon extends MsBaseCon{
  GlobalKey playBtnGlobalKey=GlobalKey();
  GlobalKey topCoinsGlobalKey=GlobalKey();

  @override
  void onReady() {
    super.onReady();
    MsP2GuideUtils.instance.showStep1Guide(context, playBtnGlobalKey);
  }

  toPlay(){
    var levelNum = P2UserInfoUtils.instance.getCurrentLevelNum();
    var routersName="";
    if(levelNum<=10){
      routersName = MsP2RoutersName.play10;
    }else if(levelNum<=20){
      routersName = MsP2RoutersName.play20;
    }else if(levelNum<=30){
      routersName = MsP2RoutersName.play30;
    }else if(levelNum<=40){
      routersName = MsP2RoutersName.play40;
    }else if(levelNum<=50){
      routersName = MsP2RoutersName.play50;
    }else if(levelNum<=60){
      routersName = MsP2RoutersName.play60;
    }else if(levelNum<=70){
      routersName = MsP2RoutersName.play70;
    }else if(levelNum<=80){
      routersName = MsP2RoutersName.play80;
    }
    if(routersName.isEmpty){
      return;
    }
    MsRouterUtils.instance.toNamed(routersName: routersName);
  }

  int getLevel(int index){
    var i = ((P2UserInfoUtils.instance.getCurrentLevelNum() - 1) ~/ 4) * 4 + 1;
    return i+index;
  }

  double getMarginTop(int index){
    switch(index){
      case 0 : return 17.h;
      case 1 : return 14.h;
      case 2 : return 9.h;
      case 3 : return 6.h;
      default: return 0;
    }
  }

  bool checkLock(int index)=>P2UserInfoUtils.instance.getCurrentLevelNum()<getLevel(index);

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.updateLevel:
        update(["level"]);
        break;
      case MsP2EventCode.clickBottomTab3:
        toPlay();
        break;
    }
  }

  test(){
    if(!kDebugMode){
      return;
    }

    // P1UserInfoUtils.instance.updateCoinsNum(-2000);
    // p1LevelNum.saveData(1);
    // P1UserInfoUtils.instance.updateDiamond(20);
    // MsVoiceUtils.instance.playMusic(MusicType.feng1);
    // P1UserInfoUtils.instance.updateDiamond(-60);
    // P2UserInfoUtils.instance.updateCoinsNum(200);
    // MsP2CashUtils.instance.updateCashTask(CashTaskName.task3Use20Tomado);

    // MsRouterUtils.instance.showDialog(child: MsP2WheelDialog());

    // MsP2GuideUtils.instance.showStep1Guide(context, playBtnGlobalKey);

    // P2UserInfoUtils.instance.updateCoinsNum(-6492);

    // MsP2LocalNotificationUtils.instance.init();
    // P2UserInfoUtils.instance.updateDiamond(2);
    // P2UserInfoUtils.instance.updateLevel(1);

    // p2Level12PlayCardNum.saveData(0);
    // print("kk===${p2LevelNum.getData()}====${p2Level12PlayCardNum.getData()}");

    // MsP2GoodCommentUtils.instance.checkShowGoodGuide();
    // p2LevelNum.saveData(10);
    // P2UserInfoUtils.instance.updateLevel(1);
    // print(P2UserInfoUtils.instance.getCurrentLevelNum());

    // MsTbaUtils.instance.sessionEvent();
    // print(MsP2ValueUtils.instance.getDiamondReward());
    // P2UserInfoUtils.instance.updateCoinsNum(2000);

    // MsAdUtils.instance.initAd();
    P2UserInfoUtils.instance.updateCoinsNum(480);
    // print("kk==+${p2AlreadyShowedReachDialog.getData()}");
  }
}