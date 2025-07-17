import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/cash_child/cash_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/game_child/game_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/home_child/home_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_good_comment_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_local_notification_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2HomeCon extends MsBaseCon{
  var chooseIndex=0;
  List<Widget> childList=[HomeChild(),CashChild(),GameChild()];

  @override
  void onInit() {
    super.onInit();
    MsP2LocalNotificationUtils.instance.init();
  }

  @override
  void onReady() {
    super.onReady();
    if(!p2FirstLaunchApp.getData()){
      MsP2GoodCommentUtils.instance.checkShowGoodGuide();
    }
    p2FirstLaunchApp.saveData(false);
  }

  clickItem(index){
    if(chooseIndex==index){
      return;
    }
    chooseIndex=index;
    update(["page"]);
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.showHomeIndex:
        clickItem(event.intValue??0);
        break;
    }
  }
}