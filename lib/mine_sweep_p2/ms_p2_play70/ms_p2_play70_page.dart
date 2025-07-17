import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play70/ms_p2_play70_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_base_play.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_card_item_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2Play70Page extends MsBasePage<MsP2Play70Con>{
  @override
  MsP2Play70Con initMsCon() => MsP2Play70Con();

  @override
  Widget buildMsWidget() => MsP2BasePlay(
    p1playUtils: msCon.p1playUtils,
    topMoneyGlobalKey: msCon.topMoneyGlobalKey,
    clickHome: (){
      msCon.clickHome();
    },
    clickResume: (){
      msCon.clickResume();
    },
    child: _listWidget(),
  );

  _listWidget()=>GetBuilder<MsP2Play70Con>(
    id: "list",
    builder: (_){
      if(msCon.p1playUtils.cardList.isEmpty){
        return Container();
      }
      return Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(0,0),
                  SizedBox(width: 36.w,),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _cardWidget(0,1),
                      SizedBox(height: 6.h,),
                      _cardWidget(0,2),
                    ],
                  ),
                  SizedBox(width: 36.w,),
                  _cardWidget(0,3),
                ],
              ),
              SizedBox(height: 65.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(0,4),
                  _cardWidget(0,5).marginOnly(left: 186.w),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,0),
                  _cardWidget(1,1).marginOnly(left: 10.w),
                ],
              ),
              SizedBox(height: 92.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,2),
                  _cardWidget(1,3).marginOnly(left: 10.w),
                ],
              ),
              SizedBox(height: 35.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,4),
                  _cardWidget(1,5).marginOnly(left: 152.w),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(2,0),
                  _cardWidget(2,1).marginOnly(left: 66.w),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(2,2),
                  _cardWidget(2,3).marginOnly(left: 66.w),
                ],
              ),
              SizedBox(height: 104.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(2,4),
                  _cardWidget(2,5).marginOnly(left: 119.w),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(3,0),
                  _cardWidget(3,1).marginOnly(left: 126.w),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(3,2),
                  _cardWidget(3,3).marginOnly(left: 8.w),
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(3,4),
                  _cardWidget(3,5).marginOnly(left: 126.w),
                ],
              ),
            ],
          ),
        ],
      );
    },
  );

  Widget _cardWidget(int fatherIndex,int childIndex){
    var bean = msCon.p1playUtils.cardList[fatherIndex][childIndex];
    return MsClick(
      onTap: (){
        msCon.clickCard(bean);
      },
      child: SizedBox(
        key: bean.globalKey,
        child: MsP2CardItemWidget(cardBean: bean),
      ),
    );
  }
}