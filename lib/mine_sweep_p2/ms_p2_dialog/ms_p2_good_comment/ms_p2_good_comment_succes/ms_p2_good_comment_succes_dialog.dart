import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_good_comment/ms_p2_good_comment_succes/ms_p2_good_comment_succes_con.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_btn_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2GoodCommentSuccesDialog extends MsBaseDialog<MsP2GoodCommentSuccesCon>{

  @override
  MsP2GoodCommentSuccesCon initMsCon() => MsP2GoodCommentSuccesCon();

  @override
  Widget buildMsWidget() => Container(
    width: double.infinity,
    height: 345.h,
    margin: EdgeInsets.only(left: 35.w,right: 35.w),
    child: Stack(
      alignment: Alignment.center,
      children: [
        MsImages(imagesName: "good6",width: double.infinity,height: double.infinity,),
        _closeWidget(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MsImages(imagesName: "good7",width: 92.w,height: 92.w,),
            SizedBox(height: 27.h,),
            MsBtnWidget(
              btnText: "Ok",
              btnBg: "btn_green",
              width: 160.w,
              height: 58.h,
              onTap: (){
                msCon.clickClose();
              },
            ),
          ],
        )
      ],
    ),
  );

  _closeWidget()=> Positioned(
    top: 0,
    right: 0,
    child: MsClick(
      onTap: (){
        msCon.clickClose();
      },
      child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
    ),
  );
}