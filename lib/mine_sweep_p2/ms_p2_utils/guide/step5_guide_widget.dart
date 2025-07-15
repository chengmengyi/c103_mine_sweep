import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/ms_p2_guide_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Step5GuideWidget extends StatelessWidget{
  Offset offset;
  Function() dismissCallback;
  Step5GuideWidget({
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
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: 87.h,
                margin: EdgeInsets.only(top: 12.h,left: 12.w,right: 12.w,),
                decoration: BoxDecoration(
                  color: "#EFF6FF".toColor(),
                  borderRadius: BorderRadius.circular(16.w),
                ),
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    MsImages(imagesName: "cash3",height: 87.h,boxFit: BoxFit.fitHeight,),
                    Row(
                      children: [
                        SizedBox(width: 26.w,),
                        MsText(text: "\$${MsP2ValueUtils.instance.getCashList().first}", size: 29.sp, color: "#060B43",useFontFamily: false,fontWeight: FontWeight.bold,),
                        Spacer(),
                        Container(
                          width: 93.w,
                          height: 38.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: "#3168B9".toColor(),
                            borderRadius: BorderRadius.circular(18.w),
                          ),
                          child: MsText(text: "Withdraw", size: 14.sp, color: "#FFFFFF",useFontFamily: false,fontWeight: FontWeight.bold,),
                        ),
                        SizedBox(width: 26.w,),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: offset.dy+50.h,
              right: 30.w,
              child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
            ),
          ],
        ),
      ),
    ),
  );
}