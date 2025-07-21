import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_controller.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum GetCoinsFrom{
  wheel,card,cash_card,pop,gem_collection,other,
}

class GetCoinsDialog extends MsBaseDialog<GetCoinsController>{
  double addNum;
  GetCoinsFrom getCoinsFrom;
  Function() success;
  bool fromDiamond;
  GetCoinsDialog({
    required this.addNum,
    required this.getCoinsFrom,
    required this.success,
    this.fromDiamond=false,
});

  @override
  init() {
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.claim_pop,params: {"pop_scene":getCoinsFrom.name});
  }

  @override
  GetCoinsController initMsCon() => GetCoinsController();

  @override
  Widget buildMsWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _titleWidget(),
      _contentWidget(),
      SizedBox(height: 12.h,),
      _btnWidget(),
    ],
  );

  _titleWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      MsClick(
        onTap: (){
          msCon.clickClose(getCoinsFrom, success);
        },
        child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
      ),
      Stack(
        alignment: Alignment.topCenter,
        children: [
          MsImages(imagesName: "diamond2",height: 65.h,boxFit: BoxFit.fitHeight,),
          MsText(text: "Congratulations", size: 25.sp, color: "#FFFFFF").marginOnly(top: 6.h),
        ],
      ),
    ],
  );

  _contentWidget()=>SizedBox(
    width: 246.w,
    height: 246.w,
    child: Stack(
      children: [
        MsImages(imagesName: "wild1",width: 246.w,height: 246.w,),
        Align(
          child: MsImages(imagesName: fromDiamond?"get1":"icon_money2",width: 106.w,height: 93.h,),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MsText(text: fromDiamond?"x${addNum.toInt()}":"+\$$addNum", size: 26.sp, color: "#11FF04",),
        )
      ],
    ),
  );

  _btnWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      MsBtnWidget(
        btnText: "Double",
        btnBg: "btn_green",
        width: 160.w,
        height: 58.h,
        topRightIcon: "icon_video",
        onTap: (){
          msCon.clickDouble(getCoinsFrom,addNum,success,fromDiamond);
        },
      ),
      SizedBox(height: 16.h,),
      MsClick(
        onTap: (){
          msCon.clickSingle(getCoinsFrom,addNum, success,fromDiamond);
        },
        child: MsText(
          text: "Collect",
          size: 14.sp,
          color: "#AAAAAA",
          withOpacity: 0.8,
          decoration: TextDecoration.underline,
          decorationColor: "#AAAAAA",
        ),
      )
    ],
  );
}