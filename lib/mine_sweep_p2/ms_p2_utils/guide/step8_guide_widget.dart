import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/ms_p2_guide_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step8GuideWidget extends StatelessWidget{
  Offset offset;
  Function() dismissCallback;
  Step8GuideWidget({
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
              child: MsImages(imagesName: "bottom1",width: 59.w,height: 63.h,),
            ),
            Positioned(
              bottom: 60.h,
              left: offset.dx+20.w,
              child: Transform.rotate(
                angle: -90,
                child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 160.h,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.w),
                margin: EdgeInsets.only(left: 42.w,right: 42.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.w),
                  color: "#F9F5ED".toColor(),
                ),
                child: MsText(text: "Using a Wild Card allows you to eliminate any card.", size: 20.sp, color: "#673431",),
              ),
            )
          ],
        ),
      ),
    ),
  );
}