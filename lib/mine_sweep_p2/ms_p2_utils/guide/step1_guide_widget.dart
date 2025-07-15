import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/ms_p2_guide_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step1GuideWidget extends StatelessWidget{
  Offset offset;
  Function() dismissCallback;
  Step1GuideWidget({
    required this.offset,
    required this.dismissCallback,
});

  @override
  Widget build(BuildContext context) => Material(
    type: MaterialType.transparency,
    child: MsClick(
      onTap: (){
        MsP2GuideUtils.instance.hideOverlay();
        dismissCallback.call();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy,
              left: offset.dx,
              child: MsImages(imagesName: "home8",width: 211.w,height: 82.h,),
            ),
            Positioned(
              top: offset.dy+30.h,
              left: offset.dx+100.w,
              child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                margin: EdgeInsets.only(left: 42.w,right: 42.w,bottom: 264.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: "#F9F5ED".toColor(),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "The first step to withdraw ",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: "#673431".toColor(),
                          fontWeight: FontWeight.bold,
                          fontFamily: "baloo",
                          height: 1.0,
                        )
                      ),
                      TextSpan(
                          text: "\$500",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: "#248500".toColor(),
                            fontWeight: FontWeight.bold,
                            fontFamily: "baloo",
                            height: 1.0,
                          )
                      ),
                      TextSpan(
                          text: " by playing the game.",
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: "#673431".toColor(),
                            fontWeight: FontWeight.bold,
                            fontFamily: "baloo",
                            height: 1.0,
                          )
                      ),
                    ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}