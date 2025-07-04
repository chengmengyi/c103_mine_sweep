import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_play_fail/ms_p1_play_fail_has_money/ms_p1_play_fail_has_money_con.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP1PlayFailHasMoneyDialog extends MsBaseDialog<MsP1PlayFailHasMoneyCon>{
  Function() clickGetCards;
  Function() clickReplay;
  Function() clickHome;
  MsP1PlayFailHasMoneyDialog({
    required this.clickGetCards,
    required this.clickReplay,
    required this.clickHome,
});
  
  @override
  MsP1PlayFailHasMoneyCon initMsCon() => MsP1PlayFailHasMoneyCon();

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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.w),
                color: "#E7D6B1".toColor(),
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    //Spend 2000 Magic Crystalsto get extra 5 cards!
                    TextSpan(
                      text: "Spend ",
                      style: TextStyle(
                        fontFamily: "baloo",
                        fontSize: 20.sp,
                        height: 1.0,
                        color: "#5D0000".toColor(),
                        fontWeight: FontWeight.bold,
                      )
                    ),
                    TextSpan(
                        text: "2000",
                        style: TextStyle(
                          fontFamily: "baloo",
                          fontSize: 20.sp,
                          height: 1.0,
                          color: "#0A9500".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    TextSpan(
                        text: " Magic Crystalsto get extra 5 cards!",
                        style: TextStyle(
                          fontFamily: "baloo",
                          fontSize: 20.sp,
                          height: 1.0,
                          color: "#5D0000".toColor(),
                          fontWeight: FontWeight.bold,
                        )
                    ),
                  ]
                ),
              ),
            ),
            MsBtnWidget(
              btnText: "Get Cards",
              btnBg: "btn_green",
              width: 160.w,
              height: 58.h,
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