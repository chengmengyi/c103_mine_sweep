import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_diamond/ms_p1_diamond_con.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP1DiamondDialog extends MsBaseDialog<MsP1DiamondCon>{

  @override
  MsP1DiamondCon initMsCon() => MsP1DiamondCon();

  @override
  Widget buildMsWidget() => Stack(
    alignment: Alignment.topCenter,
    children: [
      MsImages(imagesName: "diamond1",height: 132.h,boxFit: BoxFit.fitHeight,),
      _contentWidget(),
      _titleWidget(),
    ],
  );

  _titleWidget()=>Stack(
    alignment: Alignment.topCenter,
    children: [
      MsImages(imagesName: "diamond2",height: 65.h,boxFit: BoxFit.fitHeight,),
      MsText(text: "Gem Collection", size: 25.sp, color: "#FFFFFF").marginOnly(top: 6.h),
    ],
  ).marginOnly(top: 107.h);

  _contentWidget()=>Container(
    width: double.infinity,
    height: 382.h,
    margin: EdgeInsets.only(left: 35.w,right: 35.w,top: 132.h),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        MsImages(imagesName: "diamond3",width: double.infinity,height: double.infinity,),
        _contentListWidget(),
        Positioned(
          top: 0,
          right: 0,
          child: MsClick(
            onTap: (){
              msCon.clickClose();
            },
            child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
          ),
        ),
      ],
    ),
  );

  _contentListWidget()=>ListView.builder(
    shrinkWrap: true,
    itemCount: msCon.list.length,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context,index){
      var bean = msCon.list[index];
      return Container(
        width: double.infinity,
        height: 52.h,
        margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.w),
          color: "#E7D6B1".toColor(),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                MsImages(imagesName: "diamond7",width: 57.w,height: 52.h,),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    MsImages(imagesName: bean.icon,height: 28.h,boxFit: BoxFit.fitHeight,),
                    MsText(text: "x${bean.diamondNum}", size: 18.sp, color: "#FFFFFF",outLineColor: "#000000",).marginOnly(top: 10.h,)
                  ],
                )
              ],
            ),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MsImages(imagesName: "icon_coins",width: 21.w,height: 21.w,),
                    SizedBox(width: 4.w,),
                    MsText(text: "${bean.coinsNum}", size: 16.sp, color: "#4D280D"),
                  ],
                ),
              ),
            ),
            MsClick(
              onTap: (){
                msCon.clickCollect(bean);
              },
              child: MsImages(imagesName: p1DiamondNum.getData()>=bean.diamondNum?"diamond8":"diamond9",height: 28.h,boxFit: BoxFit.fitHeight,),
            ),
            SizedBox(width: 8.w,),
          ],
        ),
      );
    },
  ).marginOnly(bottom: 58.h);
}