import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/ms_p2_home_con.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2HomePage extends MsBasePage<MsP2HomeCon>{

  @override
  MsP2HomeCon initMsCon() => MsP2HomeCon();

  @override
  Widget buildMsWidget() => GetBuilder<MsP2HomeCon>(
    id: "page",
    builder: (_)=>Stack(
      alignment: Alignment.bottomCenter,
      children: [
        IndexedStack(
          index: msCon.chooseIndex,
          children: msCon.childList,
        ),
        _btnWidget(),
      ],
    ),
  );

  _btnWidget()=>Stack(
    alignment: Alignment.topCenter,
    children: [
      MsImages(imagesName: "home20",width: 274.w,height: 62.h,),
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _btnItemWidget(0),
          SizedBox(width: 30.w,),
          _btnItemWidget(1),
          SizedBox(width: 30.w,),
          _btnItemWidget(2),
        ],
      ),
    ],
  ).marginOnly(bottom: 20.h);

  _btnItemWidget(index)=>MsClick(
    onTap: (){
      msCon.clickItem(index);
    },
    child: MsImages(
      imagesName: index==0?"home17":index==1?"home18":"home19",
      width: msCon.chooseIndex==index?60.w:49.w,
      height: msCon.chooseIndex==index?56.h:46.h,
    ),
  );
}