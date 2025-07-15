import 'package:c103_mine_sweep/mine_sweep_base/ms_base_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_card_game/ms_p2_card_game_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_card_game_item_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class MsP2CardGameDialog extends MsBaseDialog<MsP2CardGameCon>{
  Function(double addNum) dismissDialog;
  MsP2CardGameDialog({required this.dismissDialog});

  @override
  MsP2CardGameCon initMsCon() => MsP2CardGameCon();

  @override
  Widget buildMsWidget() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      _titleWidget(),
      SizedBox(height: 10.h,),
      _listWidget(),
    ],
  );

  _listWidget()=>Container(
    margin: EdgeInsets.only(left: 35.w,right: 35.w,),
    child: MasonryGridView.count(
      itemCount: 6,
      crossAxisCount: 3,
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      mainAxisSpacing: 0,
      crossAxisSpacing: 15.w,
      itemBuilder: (context,index) => MsP2CardGameItemWidget(
        index: index,
        addNum: msCon.addNum,
        clickCardCallback: (){
          msCon.clickCardCallback(dismissDialog);
        },
      ),
    ),
  );

  _titleWidget()=>Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MsClick(
            onTap: (){
              msCon.clickClose(dismissDialog);
            },
            child: MsImages(imagesName: "icon_close",width: 34.w,height: 34.w,),
          ),
          SizedBox(height: 10.h,),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              MsImages(imagesName: "diamond2",height: 65.h,boxFit: BoxFit.fitHeight,),
              MsText(text: "Wealth Card", size: 25.sp, color: "#FFFFFF").marginOnly(top: 6.h),
            ],
          )
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MsText(text: "The max prize per spin is up to ", size: 16.sp, color: "#FFFFFF",useFontFamily: false,),
          MsText(text: "\$500.", size: 16.sp, color: "#17EA00",useFontFamily: false,fontWeight: FontWeight.bold,),
        ],
      ),
      SizedBox(height: 10.h,),
      MsImages(imagesName: "card_game1",height: 21.h,boxFit: BoxFit.fitHeight,),
    ],
  );
}