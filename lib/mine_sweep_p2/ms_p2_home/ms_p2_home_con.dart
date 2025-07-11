import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/cash_child/cash_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/game_child/game_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/home_child/home_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2HomeCon extends MsBaseCon{
  var chooseIndex=0;
  List<Widget> childList=[HomeChild(),CashChild(),GameChild()];

  clickItem(index){
    if(chooseIndex==index){
      return;
    }
    chooseIndex=index;
    update(["page"]);
  }
}