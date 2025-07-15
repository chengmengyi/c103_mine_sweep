import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:c103_mine_sweep/mine_swwep_common_page/mine_sweep_launch/ms_launch_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsLaunchPage extends MsBasePage<MsLaunchCon>{

  @override
  MsLaunchCon initMsCon() => MsLaunchCon();

  @override
  Widget buildMsWidget() => Stack(
    children: [
      MsImages(imagesName: "launch1",width: double.infinity,height: double.infinity,),
      _centerWidget(),
      launchShowBtnCommon.getData()?
      _playBtnWidget():
      _progressWidget(),
    ],
  );
  
  _centerWidget()=>Align(
    alignment: Alignment.center,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MsImages(imagesName: "logo",width: 101.w,height: 101.w,),
        MsImages(imagesName: "launch2",width: 165.w,boxFit: BoxFit.fitWidth,),
      ],
    ),
  );

  _playBtnWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: MsClick(
      onTap: (){
        msCon.checkUserType();
      },
      child: MsImages(imagesName: "home8",width: 211.w,height: 82.h,),
    ).marginOnly(bottom: 120.h),
  );

  _progressWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<MsLaunchCon>(
          id: "pro",
          builder: (_)=>MsText(text: "${(msCon.progressAnimationController.value*100).toInt()}%", size: 25.sp, color: "#FFFFFF"),
        ),
        SizedBox(
          width: 318.w,
          height: 16.h,
          child: Stack(
            children: [
              MsImages(imagesName: "launch3",width: 318.w,height: 16.h,),
              Container(
                width: 318.w,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 2.w,right: 2.w),
                child: GetBuilder<MsLaunchCon>(
                  id: "pro",
                  builder: (_)=>ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: msCon.progressAnimationController.value,
                      child: MsImages(imagesName: "launch4",width: 314.w,height: 12.h,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ).marginOnly(bottom: 120.h),
  );
}