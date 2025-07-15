import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/ms_p2_guide_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step2GuideWidget extends StatelessWidget{
  Offset offset;
  Function() dismissCallback;
  Step2GuideWidget({
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
              child: MsImages(
                imagesName: "card_money",
                width: 53.w,
                height: 79.h,
              ),
            ),
            Positioned(
              top: offset.dy+60.h,
              left: offset.dx+30.w,
              child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: offset.dy+150.h,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                margin: EdgeInsets.only(left: 42.w,right: 42.w,bottom: 264.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: "#F9F5ED".toColor(),
                ),
                child: MsText(text: "💰Click here, surprises await you", size: 20.sp, color: "#673431",),
              ),
            )
          ],
        ),
      ),
    ),
  );
}