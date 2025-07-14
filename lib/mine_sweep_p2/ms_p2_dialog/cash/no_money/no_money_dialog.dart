import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/cash/no_money/no_money_con.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoMoneyDialog extends MsBaseDialog<NoMoneyCon>{
  @override
  NoMoneyCon initMsCon() => NoMoneyCon();

  @override
  Widget buildMsWidget() => Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 32.w,right: 32.w),
    decoration: BoxDecoration(
      color: "#FFF9E8".toColor(),
      borderRadius: BorderRadius.circular(14.w),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h,),
            MsText(text: "Not enough to withdraw yet", size: 17.sp, color: "#000000",useFontFamily: false,fontWeight: FontWeight.bold,),
            SizedBox(height: 12.h,),
            MsText(text: "Play Now & Instantly Win UP TO \$500!Top up easily and withdraw instantly!", size: 14.sp, color: "#666666",useFontFamily: false,),
            SizedBox(height: 30.h,),
            MsClick(
              onTap: (){
                msCon.clickBtn();
              },
              child: Container(
                width: 180.w,
                height: 45.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: "#039A1D".toColor(),
                  borderRadius: BorderRadius.circular(20.w),
                ),
                child: MsText(text: "Instantly Credited", size: 14.sp, color: "#FFFFFF"),
              ),
            ),
            SizedBox(height: 23.h,),
          ],
        ).marginOnly(left: 13.w,right: 13.w,),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: MsClick(
            onTap: (){
              msCon.clickClose();
            },
            child: MsImages(imagesName: "icon_close2",width: 23.w,height: 23.w,),
          ),
        )
      ],
    ),
  );
}