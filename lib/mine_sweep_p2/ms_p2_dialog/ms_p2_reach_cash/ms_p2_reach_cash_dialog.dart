import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_reach_cash/ms_p2_reach_cash_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2ReachCashDialog extends MsBaseDialog<MsP2ReachCashCon>{

  @override
  MsP2ReachCashCon initMsCon() => MsP2ReachCashCon();

  @override
  Widget buildMsWidget() => Stack(
    children: [
      MsLottieWidget(lottieName: "lihua",ext: "zip",width: double.infinity,fit: BoxFit.fitWidth,),
      Align(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 35.w,right: 36.w),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _contentWidget(),
              MsImages(imagesName: "reach1",width: 248.w,height: 65.h,),
              Positioned(
                top: 32.h,
                right: 0,
                child: MsClick(
                  onTap: (){
                    msCon.clickClose();
                  },
                  child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
                ),
              )
            ],
          ),
        ),
      )
    ],
  );

  _contentWidget()=>Stack(
    alignment: Alignment.topCenter,
    children: [
      MsImages(imagesName: "reach2",width: double.infinity,height: 332.h,),
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 66.h,),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              MsImages(imagesName: "reach3",width: 150.w,height: 78.h,),
              MsText(
                text: "\$${MsP2ValueUtils.instance.getCashList().first}",
                size: 23.sp,
                color: "#060B43",
                useFontFamily: false,
                fontWeight: FontWeight.bold,
              ).marginOnly(bottom: 10.h),
            ],
          ),
          SizedBox(height: 12.h,),
          MsText(
            text: "Congrats! Top 1%—persistence wins! Cash that \$500 NOW!",
            size: 14.sp,
            color: "#500000",
            useFontFamily: false,
            fontWeight: FontWeight.bold,
          ).marginOnly(left: 30.w,right: 30.w),
          SizedBox(height: 12.h,),
          MsBtnWidget(
            btnText: "Confirm",
            btnBg: "btn_green",
            width: 180.w,
            height: 57.h,
            onTap: (){
              msCon.clickBtn();
            },
          ),
        ],
      ),
    ],
  ).marginOnly(top: 32.h);
}