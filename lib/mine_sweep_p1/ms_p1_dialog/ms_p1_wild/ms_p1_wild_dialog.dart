import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_wild/ms_p1_wild_con.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class MsP1WildDialog extends MsBaseDialog<MsP1WildCon>{
  Function() getWildCallback;
  MsP1WildDialog({required this.getWildCallback,});

  @override
  MsP1WildCon initMsCon() => MsP1WildCon();

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
      SizedBox(height: 16.h,),
      ShakeAnimationWidget(
        randomValue: 10,
        isForward: false,
        shakeCount: 0,
        shakeAnimationController: msCon.shakeAnimationController,
        shakeAnimationType: ShakeAnimationType.LeftRightShake,
        child: MsBtnWidget(
          btnText: "2000",
          btnBg: "btn_green",
          width: 160.w,
          height: 58.h,
          leftIcon: "icon_coins",
          textColor: p1CoinsNum.getData()>=1000?"#FFFFFF":"#C62828",
          onTap: (){
            msCon.clickCoins(getWildCallback);
          },
        ),
      ),
      SizedBox(height: 16.h,),
      MsBtnWidget(
        btnText: "Collect",
        btnBg: "btn_blue",
        width: 160.w,
        height: 58.h,
        topRightIcon: "icon_video",
        onTap: (){
          msCon.clickVideo(getWildCallback);
        },
      ),
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