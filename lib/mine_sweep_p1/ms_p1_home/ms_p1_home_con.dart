import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_diamond/ms_p1_diamond_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_play_fail/ms_p1_play_fail_has_money/ms_p1_play_fail_has_money_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_play_win/ms_p1_play_win_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_wild/ms_p1_wild_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/p1_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_check_af_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP1HomeCon extends MsBaseCon{

  @override
  void onInit() {
    super.onInit();
    MsCheckAfUtils.instance.setP1PageCallback((){
      MsRouterUtils.instance.offAllNamed(routersName: MsP2RoutersName.home);
    });
  }

  toPlay(){
    var levelNum = P1UserInfoUtils.instance.getCurrentLevelNum();
    var routersName="";
    if(levelNum<=10){
      routersName = MsP1RoutersName.play10;
    }else if(levelNum<=20){
      routersName = MsP1RoutersName.play20;
    }
    if(routersName.isEmpty){
      return;
    }
    MsRouterUtils.instance.toNamed(routersName: routersName);
  }

  int getLevel(int index){
    var i = ((P1UserInfoUtils.instance.getCurrentLevelNum() - 1) ~/ 4) * 4 + 1;
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

  bool checkLock(int index)=>P1UserInfoUtils.instance.getCurrentLevelNum()<getLevel(index);

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP1EventCode.updateLevel:
        update(["level"]);
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
    MsAdUtils.instance.initAd();
  }
}