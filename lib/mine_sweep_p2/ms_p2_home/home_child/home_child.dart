import 'package:c103_mine_sweep/mine_sweep_base/ms_base_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/home_child/home_child_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_coins_finger_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_home_cash_pro_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_top_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_h5/flutter_h5.dart';
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
          MsP2TopWidget(showLevel: false,topCoinsGlobalKey: msCon.topCoinsGlobalKey,),
          MsP2HomeCashProWidget(
            clickPlayCallback: (){
              msCon.toPlay();
            },
          ),
          _levelListWidget(),
          _btnWidget(),
        ],
      ),
      MsP2CoinsFingerWidget(globalKey: msCon.topCoinsGlobalKey,fromHome: true,),
      Positioned(
        top: 260.h,
        right: 15.w,
        child: MsClick(
          onTap: (){
            FlutterH5.instance.ms4H5();
          },
          child: MsImages(imagesName: "icon_game",width: 50.w,height: 50.w,),
        ),
      ),
    ],
  );

  _levelListWidget()=>Expanded(
    child: GetBuilder<HomeChildCon>(
      id: "level",
      builder: (_)=>Stack(
        children: [
          Positioned(
            right: 120.w,
            bottom: 22.h,
            child: MsClick(
              onTap: (){
                msCon.test();
              },
              child: _itemWidget(82.w,70.h,0),
            ),
          ),
          Positioned(
            left: 106.w,
            bottom: 116.h,
            child: _itemWidget(74.w,68.h,1),
          ),
          Positioned(
            left: 88.w,
            bottom: 216.h,
            child: _itemWidget(58.w,52.h,2),
          ),
          Positioned(
            left: 149.w,
            bottom: 283.h,
            child: _itemWidget(53.w,45.h,3),
          ),
          Positioned(
            left: 106.w,
            bottom: 355.h,
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
      MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.home_page_play);
      msCon.toPlay();
    },
    child: SizedBox(
      key: msCon.playBtnGlobalKey,
      child: MsImages(imagesName: "home8",width: 211.w,height: 82.h,),
    ),
  ).marginOnly(bottom: 90.h);

}