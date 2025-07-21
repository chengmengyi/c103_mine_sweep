import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_play_fail/ms_p2_play_fail_con.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2PlayFailDialog extends MsBaseDialog<MsP2PlayFailCon>{
  Function() clickGetCards;
  Function() clickReplay;
  Function() clickHome;
  MsP2PlayFailDialog({
    required this.clickGetCards,
    required this.clickReplay,
    required this.clickHome,
});
  
  @override
  MsP2PlayFailCon initMsCon() => MsP2PlayFailCon();

  @override
  Widget buildMsWidget() => Container(
    width: double.infinity,
    height: 427.h,
    margin: EdgeInsets.only(left: 35.w,right: 35.w),
    child: Stack(
      children: [
        MsImages(imagesName: "has1",width: double.infinity, height: 427.h,),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.h,),
              MsText(text: "Out Of Cards", size: 25.sp, color: "#FFFFFF",outLineColor: "#000000",),
              SizedBox(height: 10.h,),
              _contentWidget(),
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: MsClick(
            onTap: (){
              msCon.clickHome(clickHome);
            },
            child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
          ),
        )
      ],
    ),
  );

  _contentWidget()=>Container(
    width: double.infinity,
    height: 350.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        MsImages(imagesName: "has2",width:  double.infinity,height: double.infinity,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              height: 138.h,
              alignment: Alignment.center,
              margin: EdgeInsets.all(15.w),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: "#E7D6B1".toColor(),
              ),
              child: MsText(text: "Watch a short video to get extra 5 cards!", size: 20.sp, color: "#5D0000"),
            ),
            MsBtnWidget(
              btnText: "Get Cards",
              btnBg: "btn_green",
              width: 160.w,
              height: 58.h,
              topRightIcon: "icon_video",
              onTap: (){
                msCon.clickGetCards(clickGetCards);
              },
            ),
            SizedBox(height: 10.h,),
            MsBtnWidget(
              btnText: "Replay",
              btnBg: "btn_blue",
              width: 160.w,
              height: 58.h,
              onTap: (){
                msCon.clickReplay(clickReplay);
              },
            ),
            SizedBox(height: 10.h,),
            MsClick(
              onTap: (){
                msCon.clickHome(clickHome);
              },
              child: MsText(
                text: "Home",
                size: 14.sp,
                color: "#747474",
                decoration: TextDecoration.underline,
                decorationColor: "#747474",
              ),
            )
          ],
        )
      ],
    ),
  );
}