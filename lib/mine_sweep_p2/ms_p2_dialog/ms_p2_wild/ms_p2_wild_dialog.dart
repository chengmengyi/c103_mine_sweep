import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_wild/ms_p2_wild_con.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class MsP2WildDialog extends MsBaseDialog<MsP2WildCon>{
  Function() getWildCallback;
  MsP2WildDialog({required this.getWildCallback,});

  @override
  MsP2WildCon initMsCon() => MsP2WildCon();

  @override
  Widget buildMsWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MsClick(
            onTap: (){
              msCon.clickClose();
            },
            child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
          ),
          SizedBox(width: 30.w,),
        ],
      ),
      _contentWidget(),
      // SizedBox(height: 16.h,),
      // ShakeAnimationWidget(
      //   randomValue: 10,
      //   isForward: false,
      //   shakeCount: 0,
      //   shakeAnimationController: msCon.shakeAnimationController,
      //   shakeAnimationType: ShakeAnimationType.LeftRightShake,
      //   child: MsBtnWidget(
      //     btnText: "1000",
      //     btnBg: "btn_green",
      //     width: 160.w,
      //     height: 58.h,
      //     leftIcon: "icon_coins",
      //     textColor: p2CoinsNum.getData()>=1000?"#FFFFFF":"#C62828",
      //     onTap: (){
      //       msCon.clickCoins(getWildCallback);
      //     },
      //   ),
      // ),
      SizedBox(height: 16.h,),
      MsBtnWidget(
        btnText: "Collect",
        btnBg: "btn_green",
        width: 160.w,
        height: 58.h,
        topRightIcon: "icon_video",
        onTap: (){
          msCon.clickVideo(getWildCallback);
        },
      ),
      SizedBox(height: 16.h,),
      MsClick(
        onTap: (){
          msCon.clickClose();
        },
        child: MsText(
          text: "No Thanks",
          size: 14.sp,
          color: "#AAAAAA",
          decoration: TextDecoration.underline,
          decorationColor: "#AAAAAA",
        ),
      )
    ],
  );

  _contentWidget()=>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Stack(
        alignment: Alignment.center,
        children: [
          MsImages(imagesName: "wild1",width: 246.w,height: 246.w,),
          ScaleTransition(
            scale: msCon.boxScaleAnimation,
            child: MsImages(imagesName: "wild2",width: 78.w,height: 106.h,),
          ),
        ],
      ),
      MsText(text: "Get more wild cards to win!", size: 20.sp, color: "#FFFFFF")
    ],
  );
}