import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_wheel/ms_p2_wheel_con.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2WheelDialog extends MsBaseDialog<MsP2WheelCon>{
  Function(double addNum) dismissDialog;
  MsP2WheelDialog({required this.dismissDialog});

  @override
  MsP2WheelCon initMsCon() => MsP2WheelCon();

  @override
  Widget buildMsWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _titleWidget(),
      SizedBox(height: 10.h,),
      _wheelWidget(),
    ],
  );

  _wheelWidget()=>Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 12.w,right: 12.w),
    child: AspectRatio(
      aspectRatio: 0.9,
      child: Stack(
        children: [
          MsImages(imagesName: "wheel1",width: double.infinity,height: double.infinity,),
          Container(
            margin: EdgeInsets.all(22.w),
            child: LayoutBuilder(
              builder: (context,bc){
                var size = bc.maxWidth;
                final radius = (size / 2 - 30)*0.9;
                return AspectRatio(
                  aspectRatio: 1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: msCon.animation,
                        builder: (context,child)=>Transform.rotate(
                          angle: msCon.animation.value,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              MsImages(imagesName: "wheel2",width: double.infinity,height: double.infinity,),
                              for (int i = 0; i < msCon.numList.length; i++)
                                _buildRotatedText(
                                  text: msCon.numList[i],
                                  angleDeg: i * 45.0 - 90,
                                  radius: radius,
                                )
                            ],
                          ),
                        ),
                      ),
                      MsClick(
                        onTap: (){
                          msCon.startWheel(dismissDialog);
                        },
                        child: MsImages(imagesName: "wheel3",width: 66.w,height: 83.h,),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );


  Widget _buildRotatedText({
    required int text,
    required double angleDeg,
    required double radius,
  }) {
    final angleRad = angleDeg * pi / 180;
    final offset = Offset(
      radius * cos(angleRad),
      radius * sin(angleRad),
    );

    final textRotation = angleRad + pi / 2;

    return Transform.translate(
      offset: offset,
      child: Transform.rotate(
        angle: textRotation,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MsImages(imagesName: "wheel4",width: 48.w,height: 32.h,),
            MsText(text: "\$$text", size: 16.sp, color: "#FFFFFF",outLineColor: "#000000",useFontFamily: false,fontWeight: FontWeight.bold,)
          ],
        ),
      ),
    );
  }

  _titleWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MsClick(
            onTap: (){
              msCon.clickClose(dismissDialog);
            },
            child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
          ),
          SizedBox(height: 10.h,),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              MsImages(imagesName: "diamond2",height: 65.h,boxFit: BoxFit.fitHeight,),
              MsText(text: "Wealth Card", size: 25.sp, color: "#FFFFFF").marginOnly(top: 6.h),
            ],
          )
        ],
      ),
      SizedBox(height: 10.h,),
      SizedBox(
        height: 30.h,
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText("The max prize per spin is up to \$500."),
              RotateAnimatedText("The earlier! Withdraw your \$500 now."),
              RotateAnimatedText("Just \$0.05 to Pagbank withdraw."),
              RotateAnimatedText("Your \$500 Prize - One Spin Away!"),
            ],
            repeatForever: true,
          ),
        ),
      ),
    ],
  );
}