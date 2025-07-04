import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_set/ms_p1_set_con.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP1SetDialog extends MsBaseDialog<MsP1SetCon>{
  bool fromHome;
  Function()? clickHome;
  Function()? clickResume;
  MsP1SetDialog({
    required this.fromHome,
    this.clickHome,
    this.clickResume,
  });

  @override
  MsP1SetCon initMsCon() => MsP1SetCon();

  @override
  Widget buildMsWidget() => Container(
    width: double.infinity,
    height: 456.h,
    margin: EdgeInsets.only(left: 35.w,right: 35.w),
    child: Stack(
      children: [
        MsImages(imagesName: "set1",width: double.infinity, height: 456.h,),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h,),
              MsText(text: "Setting", size: 25.sp, color: "#FFFFFF",outLineColor: "#000000",),
              SizedBox(height: 30.h,),
              _switchBgWidget(),
              SizedBox(height: 25.h,),
              _switchVoiceWidget(),
              SizedBox(height: 25.h,),
              MsClick(
                onTap: (){
                  msCon.clickPrivacy();
                },
                child: MsImages(imagesName: "set4",width: 215.w,height: 57.h,),
              ),
              Visibility(
                visible: !fromHome,
                child: MsClick(
                  onTap: (){
                    msCon.clickHome(clickHome);
                  },
                  child: MsImages(imagesName: "set5",width: 215.w,height: 57.h,).marginOnly(top: 10.h),
                ),
              ),
              Visibility(
                visible: !fromHome,
                child: MsClick(
                  onTap: (){
                    msCon.clickResume(clickResume);
                  },
                  child: MsImages(imagesName: "set6",width: 215.w,height: 57.h,).marginOnly(top: 10.h),
                ),
              ),
            ],
          ),
        ),
        Positioned(
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
  );

  _switchBgWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      MsImages(imagesName: "set2",width: 40.w,height: 43.h,),
      SizedBox(width: 26.w,),
      GetBuilder<MsP1SetCon>(
        id: "bg",
        builder: (_)=>MsClick(
          onTap: (){
            msCon.clickBg();
          },
          child: MsImages(imagesName: bgMusicSwitch.getData()?"switch_on":"switch_off",width: 96.w,height: 40.h,),
        ),
      )
    ],
  );

  _switchVoiceWidget()=>Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      MsImages(imagesName: "set3",width: 45.w,height: 33.h,),
      SizedBox(width: 26.w,),
      GetBuilder<MsP1SetCon>(
        id: "voice",
        builder: (_)=>MsClick(
          onTap: (){
            msCon.clickVoice();
          },
          child: MsImages(imagesName: voiceMusicSwitch.getData()?"switch_on":"switch_off",width: 96.w,height: 40.h,),
        ),
      )
    ],
  );
}