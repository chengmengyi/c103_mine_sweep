import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_card_game/ms_p2_card_game_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_cash_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeChildCon extends MsBaseCon{
  toPlay(){
    var levelNum = P2UserInfoUtils.instance.getCurrentLevelNum();
    var routersName="";
    if(levelNum<=10){
      routersName = MsP2RoutersName.play10;
    }else if(levelNum<=20){
      routersName = MsP2RoutersName.play20;
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

    MsRouterUtils.instance.showDialog(child: MsP2CardGameDialog());
  }
}