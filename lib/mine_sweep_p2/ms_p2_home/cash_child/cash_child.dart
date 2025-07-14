import 'package:c103_mine_sweep/mine_sweep_base/ms_base_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_list_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_task_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/cash_child/cash_child_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CashChild extends MsBaseChild<CashChildCon>{

  @override
  CashChildCon initMsCon() => CashChildCon();

  @override
  Widget buildMsWidget() => Container(
    width: double.infinity,
    height: double.infinity,
    color: "#FFF9E8".toColor() ,
    child: GetBuilder<CashChildCon>(
      id: "page",
      builder: (_)=>Column(
        children: [
          _topMoneyWidget(),
          SizedBox(height: 20.h,),
          _cashTypeWidget(),
          SizedBox(height: 20.h,),
          _cashMoneyListWidget(),
        ],
      ),
    ),
  );

  _topMoneyWidget()=>SizedBox(
    width: double.infinity,
    height: 191.h,
    child: Stack(
      children: [
        MsImages(imagesName: msCon.cashTypeIndex==0?"cash1":"cash4",width: double.infinity,height: double.infinity,),
        SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: 96.h,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10.w,right: 10.w),
            margin: EdgeInsets.only(left: 10.w,right: 10.w,top: 10.h),
            decoration: BoxDecoration(
              color: msCon.cashTypeIndex==0?"#07265F".toColor():"#005A2D".toColor() ,
              borderRadius: BorderRadius.circular(16.w),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MsText(
                      text: "Balance",
                      size: 16.sp,
                      color: "#FFFFFF",
                      withOpacity: 0.8,
                      useFontFamily: false,
                      fontWeight: FontWeight.bold,
                    ),
                    Spacer(),
                    MsImages(imagesName: "cash2",width: 24.w,height: 24.w,),
                    SizedBox(width: 8.w,),
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
                    )
                  ],
                ),
                GetBuilder<CashChildCon>(
                  id: "coins",
                  builder: (_)=>MsText(
                    text: "\$${p2CoinsNum.getData()}",
                    size: 20.sp,
                    color: "#FFFFFF",
                    useFontFamily: false,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
  
  _cashTypeWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    margin: EdgeInsets.only(left: 14.w,top: 14.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(20.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MsText(
          text: "Choose Your Withdrawal Method",
          size: 15.sp,
          color: "#000000",
          useFontFamily: false,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 10.h,),
        _cashTypeItemWidget(0),
        SizedBox(height: 10.h,),
        _cashTypeItemWidget(1),
      ],
    ),
  );

  _cashTypeItemWidget(index)=>Row(
    children: [
      Container(
        width: 115.w,
        height: 40.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.w),
          gradient: LinearGradient(
            colors: index==0?["#B1ECFF".toColor(),"#C3CDFE".toColor(),]:["#B1FFE2".toColor(),"#C3FED9".toColor(),]
          ),
        ),
        child: MsImages(imagesName: index==0?"cash_pay":"cash_cash",height: 28.h,boxFit: BoxFit.fitHeight,),
      ),
      Spacer(),
      MsClick(
        onTap: (){
          msCon.clickCashType(index);
        },
        child: MsImages(imagesName: msCon.cashTypeIndex==index?"icon_sel":"icon_uns",width: 25.w,height: 25.w,),
      ),
    ],
  );

  _cashMoneyListWidget()=>Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.w),
    margin: EdgeInsets.only(left: 14.w,top: 14.w),
    decoration: BoxDecoration(
      color: "#FFFFFF".toColor(),
      borderRadius: BorderRadius.circular(20.w),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MsText(
          text: "Choose Your Withdrawal Method",
          size: 15.sp,
          color: "#000000",
          useFontFamily: false,
          fontWeight: FontWeight.w500,
        ),
        MediaQuery.removePadding(
          context: msCon.context,
          removeTop: true,
          removeBottom: true,
          child: GetBuilder<CashChildCon>(
            id: "cash_list",
            builder: (_)=>ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: msCon.cashList.length,
              itemBuilder: (context,index){
                var bean = msCon.cashList[index];
                return Container(
                  width: double.infinity,
                  height: 87.h,
                  margin: EdgeInsets.only(top: 12.h),
                  decoration: BoxDecoration(
                    color: "#EFF6FF".toColor(),
                    borderRadius: BorderRadius.circular(16.w),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      MsImages(imagesName: msCon.cashTypeIndex==0?"cash3":"cash5",height: 87.h,boxFit: BoxFit.fitHeight,),
                      null==bean.cashTaskBean?
                      _noCashTaskWidget(bean):
                      _hasCashTaskWidget(bean),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Visibility(
                          visible: msCon.getTopRightStr(bean).isNotEmpty,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              MsImages(imagesName: "cash6",width: 66.w,height: 22.h,),
                              MsText(text: msCon.getTopRightStr(bean), size: 10.sp, color: "#FFFFFF",useFontFamily: false,fontWeight: FontWeight.bold,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );

  _hasCashTaskWidget(MsP2CashListBean bean)=>MsClick(
    onTap: (){
      msCon.clickCash(bean);
    },
    child: Row(
      children: [
        SizedBox(width: 26.w,),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: msCon.getCashTaskLeftStr(bean.cashTaskBean),
                      style: TextStyle(
                        color: "#000000".toColor(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: msCon.getCashTaskCenterStr(bean.cashTaskBean),
                      style: TextStyle(
                        color: "#F95700".toColor(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: msCon.getCashTaskRightStr(bean.cashTaskBean),
                      style: TextStyle(
                        color: "#000000".toColor(),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
                ),
              ),
              SizedBox(height: 10.h,),
              LayoutBuilder(
                builder: (context,bc){
                  var maxWidth = bc.maxWidth;
                  return Container(
                    width: maxWidth,
                    height: 9.h,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: "#D8DCE2".toColor(),
                      borderRadius: BorderRadius.circular(10.w),
                    ),
                    child: Container(
                      width: maxWidth*msCon.getPro(bean.cashTaskBean),
                      height: 9.h,
                      decoration: BoxDecoration(
                        color: "#1FAB26".toColor(),
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        SizedBox(width: 10.w,),
        MsText(text: "\$${bean.cashAmount}", size: 29.sp, color: "#060B43",useFontFamily: false,fontWeight: FontWeight.bold,),
        SizedBox(width: 10.w,),
      ],
    ),
  );

  _noCashTaskWidget(MsP2CashListBean bean)=>Row(
    children: [
      SizedBox(width: 26.w,),
      MsText(text: "\$${bean.cashAmount}", size: 29.sp, color: "#060B43",useFontFamily: false,fontWeight: FontWeight.bold,),
      Spacer(),
      MsClick(
        onTap: (){
          msCon.clickCash(bean);
        },
        child: Container(
          width: 93.w,
          height: 38.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: "#3168B9".toColor(),
            borderRadius: BorderRadius.circular(18.w),
          ),
          child: MsText(text: "Withdraw", size: 14.sp, color: "#FFFFFF",useFontFamily: false,fontWeight: FontWeight.bold,),
        ),
      ),
      SizedBox(width: 26.w,),
    ],
  );
}