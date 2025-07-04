import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsBtnWidget extends StatelessWidget{
  String btnText;
  String btnBg;
  double width;
  double height;
  String? leftIcon;
  String? topRightIcon;
  String? textColor;
  Function() onTap;
  MsBtnWidget({
    required this.btnText,
    required this.btnBg,
    required this.width,
    required this.height,
    required this.onTap,
    this.leftIcon,
    this.topRightIcon,
    this.textColor,
});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: MsClick(
      onTap: (){
        onTap.call();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          MsImages(imagesName: btnBg,width: width,height: height,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              null==leftIcon?Container():MsImages(imagesName: leftIcon??"",width: 30.w,height: 30.w,boxFit: BoxFit.cover,),
              SizedBox(width: 2.w,),
              MsText(text: btnText, size: 24.sp, color: textColor??"#FFFFFF",outLineColor: "#221E6F",)
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: null==topRightIcon?Container():MsImages(imagesName: topRightIcon??"",width: 30.w,boxFit: BoxFit.fitWidth,),
          )
        ],
      ),
    ),
  );
}