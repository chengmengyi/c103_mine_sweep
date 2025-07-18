import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_no_network/ms_p2_no_network_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2NoNetworkDialog extends MsBaseDialog<MsP2NoNetworkCon>{
  GetCoinsFrom getCoinsFrom;
  MsP2NoNetworkDialog({required this.getCoinsFrom,});

  @override
  init() {
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.claim_nointernet_pop,params: {"pop_scene":getCoinsFrom.name});
  }

  @override
  MsP2NoNetworkCon initMsCon() => MsP2NoNetworkCon();

  @override
  Widget buildMsWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      MsImages(imagesName: "network1",width: 110.w,height: 110.w,),
      SizedBox(height: 12.h,),
      MsText(text: "Connect, and you can earn more.", size: 16.sp, color: "#FFFFFF"),
      SizedBox(height: 12.h,),
      MsBtnWidget(
        btnText: "Got it",
        btnBg: "btn_green",
        width: 160.w,
        height: 58.h,
        onTap: (){
          MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.claim_nointernet_pop_got,params: {"pop_scene":getCoinsFrom.name});
          MsRouterUtils.instance.back();
        },
      ),
    ],
  );
}