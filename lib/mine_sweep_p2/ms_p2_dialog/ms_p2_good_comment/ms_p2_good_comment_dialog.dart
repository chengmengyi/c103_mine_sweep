import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_good_comment/ms_p2_good_comment_con.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2GoodCommentDialog extends MsBaseDialog<MsP2GoodCommentCon>{
  Function(int index) clickStarCallback;
  MsP2GoodCommentDialog({required this.clickStarCallback});

  @override
  MsP2GoodCommentCon initMsCon() => MsP2GoodCommentCon();

  @override
  Widget buildMsWidget() => Container(
    margin: EdgeInsets.only(left: 36.w,right: 36.w),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        _contentWidget(),
        _topWidget(),
        _closeWidget(),
      ],
    ),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: 382.h,
    margin: EdgeInsets.only(top: 34.h),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        MsImages(imagesName: "good2",width: double.infinity,height: double.infinity,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 72.h,),
            MsImages(imagesName: "good3",width: 70.w,height: 70.w,),
            SizedBox(height: 32.h,),
            GetBuilder<MsP2GoodCommentCon>(
              id: "list",
              builder: (_)=>Container(
                width: double.infinity,
                height: 40.h,
                alignment: Alignment.center,
                child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                    return MsClick(
                      onTap: (){
                        msCon.clickStar(index);
                      },
                      child: MsImages(imagesName: msCon.clickIndex>=index?"good5":"good4",width: 40.w,height: 40.h,),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MsText(text: "Complete reviews earn \$5", size: 14.sp, color: "#673431",useFontFamily: false,fontWeight: FontWeight.bold,),
                SizedBox(width: 2.w,),
                MsImages(imagesName: "icon_money",width: 38.w,height: 26.h,),
              ],
            ),
            SizedBox(height: 16.h,),
            MsBtnWidget(
              btnText: "Got it",
              btnBg: "btn_green",
              width: 160.w,
              height: 58.h,
              onTap: (){
                msCon.clickSure(clickStarCallback);
              },
            ),
          ],
        ),
        Positioned(
          top: 194.h,
          right: 20.w,
          child: GetBuilder<MsP2GoodCommentCon>(
            id: "finger",
            builder: (_)=>Visibility(
              visible: msCon.showFinger,
              child: MsClick(
                onTap: (){
                  msCon.clickStar(4);
                },
                child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  _topWidget()=>Stack(
    alignment: Alignment.topCenter,
    children: [
      MsImages(imagesName: "good1",width: 248.w,height: 66.h,),
      MsText(
        text: "Give Us A Good\nReview",
        size: 22.sp,
        color: "#FFFFFF",
        textAlign: TextAlign.center,
        height: 1,
        outLineColor: "#000000",
      ).marginOnly(top: 5.h),
    ],
  );

  _closeWidget()=> Positioned(
    top: 30.h,
    right: 0,
    child: MsClick(
      onTap: (){
        msCon.clickClose();
      },
      child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
    ),
  );
}