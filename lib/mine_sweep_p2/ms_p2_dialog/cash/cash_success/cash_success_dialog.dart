import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_task_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/cash/cash_success/cash_success_con.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class CashSuccessDialog extends MsBaseDialog<CashSuccessCon>{
  MsP2CashTaskBean? bean;
  CashSuccessDialog({required this.bean});

  @override
  init() {
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.withdraw_task_pop,params: {"withdraw_step":"step4"});
  }


  @override
  CashSuccessCon initMsCon() => CashSuccessCon();

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
            MsText(text: "Congratulations!", size: 17.sp, color: "#000000",useFontFamily: false,fontWeight: FontWeight.bold,),
            SizedBox(height: 12.h,),
            MsText(text: "We have completed the payment.And the funds will be creadited to your bank account within 7 business days.", size: 14.sp, color: "#666666",useFontFamily: false,),
            SizedBox(height: 30.h,),
            MsClick(
              onTap: (){
                msCon.clickBtn(bean);
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