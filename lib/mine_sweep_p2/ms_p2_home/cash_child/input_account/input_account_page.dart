import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/cash_child/input_account/input_account_controller.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputAccountPage extends MsBasePage<InputAccountController>{

  @override
  InputAccountController initMsCon() => InputAccountController();

  @override
  Widget buildMsWidget() => Container(
    width: double.infinity,
    height: double.infinity,
    color: "#FFF9E8".toColor(),
    child: Stack(
      children: [
        _topWidget(),
        _inputWidget(),
      ],
    ),
  );

  _inputWidget()=>Column(
    children: [
      Container(
        width: double.infinity,
        height: 72.h,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 14.w,right: 14.w),
        margin: EdgeInsets.only(top: 206.h,left: 14.w,right: 14.w),
        decoration: BoxDecoration(
          color: "#FFFFFF".toColor(),
          borderRadius: BorderRadius.circular(6.w),
        ),
        child: Row(
          children: [
            MsText(text: "Account", size: 14.sp, color: "#000000",),
            Expanded(
              child: TextField(
                enabled: true,
                textAlign: TextAlign.right,
                controller: msCon.textEditingController,
                maxLength: msCon.cashTypeIndex==1?10:null,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: "#000000".toColor(),
                ),
                decoration: InputDecoration(
                  counterText: '',
                  isCollapsed: true,
                  hintText: msCon.cashTypeIndex==1?'e.g.5551234567':"e.g. 123456789@abc.com",
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: "#000000".toColor().withOpacity(0.2),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 200.h,),
      MsClick(
        onTap: (){
          msCon.clickBtn();
        },
        child: Container(
          width: double.infinity,
          height: 51.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 30.w,right: 30.w),
          decoration: BoxDecoration(
            color: "#008712".toColor(),
            borderRadius: BorderRadius.circular(50.w),
          ),
          child: MsText(text: "Confirm", size: 14.sp, color: "#FFFFFF",),
        ),
      )
    ],
  );

  _topWidget()=>Stack(
    children: [
      MsImages(imagesName: "input1",width: double.infinity,height: 216.h,),
      SafeArea(
        top: true,
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                MsRouterUtils.instance.back();
              },
              icon: Icon(Icons.arrow_back,color: Colors.white,),
            ),
            MsImages(imagesName: msCon.cashTypeIndex==0?"cash_pay":"cash_cash",height: 32.h,),
            Spacer(),
            Container(
              width: 68.w,
              height: 25.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: "#000000".toColor().withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: MsText(
                text: "ID:${p2UserId.getData()}",
                size: 10.sp,
                color: "#FFFFFF",
                useFontFamily: false,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 16.w,),
          ],
        ),
      )
    ],
  );
}