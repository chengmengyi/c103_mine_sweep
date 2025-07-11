import 'package:c103_mine_sweep/mine_sweep_base/ms_base_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/home_child/home_child_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_home_cash_pro_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_top_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeChild extends MsBaseChild<HomeChildCon>{

  @override
  HomeChildCon initMsCon() => HomeChildCon();

  @override
  Widget buildMsWidget() => Stack(
    children: [
      MsImages(imagesName: "home1",width: double.infinity,height: double.infinity,),
      Column(
        children: [
          MsP2TopWidget(showLevel: false,),
          MsP2HomeCashProWidget(),
          _levelListWidget(),
          _btnWidget(),
        ],
      )
    ],
  );

  _levelListWidget()=>Expanded(
    child: GetBuilder<HomeChildCon>(
      id: "level",
      builder: (_)=>Stack(
        children: [
          Positioned(
            right: 120.w,
            bottom: 32.h,
            child: MsClick(
              onTap: (){
                msCon.test();
              },
              child: _itemWidget(82.w,70.h,0),
            ),
          ),
          Positioned(
            left: 106.w,
            bottom: 126.h,
            child: _itemWidget(74.w,68.h,1),
          ),
          Positioned(
            left: 88.w,
            bottom: 226.h,
            child: _itemWidget(58.w,52.h,2),
          ),
          Positioned(
            left: 149.w,
            bottom: 293.h,
            child: _itemWidget(53.w,45.h,3),
          ),
          Positioned(
            left: 106.w,
            bottom: 366.h,
            child: _itemWidget(46.w,42.h,4),
          ),
        ],
      ),
    ),
  );

  _itemWidget(double width,double height,int index){
    var lock = msCon.checkLock(index);
    if(lock){
      return MsImages(imagesName: "home9",width: width,height: height,);
    }
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        MsImages(imagesName: "home7",width: width,height: height,),
        MsText(text: "LV${msCon.getLevel(index)}", size: 13.sp, color: "#FFFFFF",outLineColor: "#4F0000",).marginOnly(top: msCon.getMarginTop(index))
      ],
    );
  }

  _btnWidget()=>MsClick(
    onTap: (){
      msCon.toPlay();
    },
    child: MsImages(imagesName: "home8",width: 211.w,height: 82.h,),
  ).marginOnly(bottom: 72.h);

}