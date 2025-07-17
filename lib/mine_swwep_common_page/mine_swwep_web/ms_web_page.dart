import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_swwep_common_page/mine_swwep_web/ms_web_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MsWebPage extends MsBasePage<MsWebCon>{

  @override
  MsWebCon initMsCon() => MsWebCon();

  @override
  Widget buildMsWidget() => Container(
    color: Colors.white,
    child: SafeArea(
      top: true,
      bottom: true,
      child: Column(
        children: [
          _topWidget(),
          Expanded(child: WebViewWidget(controller: msCon.controller))
        ],
      ),
    ),
  );

  _topWidget()=>Container(
    width: double.infinity,
    height: 36.w,
    padding: EdgeInsets.only(left: 16.w),
    alignment: Alignment.centerLeft,
    child: MsClick(
      onTap: (){
        MsRouterUtils.instance.back();
      },
      child: MsImages(imagesName: "icon_close3",width: 36.w,height: 36.w,),
    ),
  );
}