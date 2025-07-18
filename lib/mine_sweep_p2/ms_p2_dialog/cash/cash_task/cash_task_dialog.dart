import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_task_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/cash/cash_task/cash_task_con.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class CashTaskDialog extends MsBaseDialog<CashTaskCon>{
  MsP2CashTaskBean? bean;
  CashTaskDialog({required this.bean});

  @override
  init() {
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.withdraw_task_pop,params: {"withdraw_step":bean?.cashTask});
  }


  @override
  CashTaskCon initMsCon() => CashTaskCon();

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
            MsText(text: "Withdrawal Unlock", size: 17.sp, color: "#000000",useFontFamily: false,fontWeight: FontWeight.bold,),
            SizedBox(height: 12.h,),
            MsText(text: "To ensure the security of your account, you need to complete the following tasks to verify that you are a real person", size: 14.sp, color: "#666666",useFontFamily: false,),
            SizedBox(height: 30.h,),
            Container(
              width: double.infinity,
              height: 65.h,
              padding: EdgeInsets.only(left: 10.w,right: 10.w),
              decoration: BoxDecoration(
                color: "#F5EAD4".toColor(),
                borderRadius: BorderRadius.circular(18.w),
              ),
              child: Row(
                children: [
                  MsImages(imagesName: msCon.getIcon(bean),width: 40.w,height: 40.w,),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: MsText(text: msCon.getContentStr(bean), size: 14.sp, color: "#000000",useFontFamily: false,fontWeight: FontWeight.bold,),
                  ),
                  MsText(text: "${bean?.currentPro??0}/${bean?.totalPro??0}", size: 14.sp, color: "#F54A0C",useFontFamily: false,fontWeight: FontWeight.bold,),
                  SizedBox(width: 10.w,),
                ],
              ),
            ),
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