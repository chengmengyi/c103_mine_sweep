import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_play_win/ms_p1_play_win_con.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP1PlayWinDialog extends MsBaseDialog<MsP1PlayWinCon>{
  int rewards;
  Function() clickNext;
  Function() clickHome;
  MsP1PlayWinDialog({
    required this.rewards,
    required this.clickNext,
    required this.clickHome,
});

  @override
  MsP1PlayWinCon initMsCon() => MsP1PlayWinCon();

  @override
  Widget buildMsWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      MsImages(imagesName: "win1",height: 65.h,boxFit: BoxFit.fitHeight,),
      Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              MsImages(imagesName: "win2",width: 238.w,height: 238.w,),
              MsImages(imagesName: "win3",width: 184.w,height: 160.w,),
            ],
          ),
          Visibility(
            visible: rewards!=0,
            child: MsText(text: "+$rewards", size: 33.sp, color: "#F7E40E"),
          ),
        ],
      ),
      SizedBox(height: 20.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MsImages(imagesName: "win4",width: 44.w,height: 44.w,),
          SizedBox(width: 2.w,),
          MsText(text: "+1", size: 33.sp, color: "#FFFFFF"),
        ],
      ),
      SizedBox(height: 20.h,),
      MsClick(
        onTap: (){
          msCon.clickNext(clickNext);
        },
        child: MsImages(
          imagesName: "win5",
          width: 160.w,
          height: 57.h,
        ),
      ),
      SizedBox(height: 20.h,),
      MsClick(
        onTap: (){
          msCon.clickHome(clickHome);
        },
        child: MsText(
          text: "Home",
          size: 14.sp,
          color: "#FFFFFF",
          withOpacity: 0.8,
          decoration: TextDecoration.underline,
          decorationColor: "#FFFFFF",
        ),
      ),
    ],
  );
}