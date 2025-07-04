import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_play20/ms_p1_play20_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_p1_base_play.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_p1_card_item_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP1Play20Page extends MsBasePage<MsP1Play20Con>{
  @override
  MsP1Play20Con initMsCon() => MsP1Play20Con();

  @override
  Widget buildMsWidget() => MsP1BasePlay(
    p1playUtils: msCon.p1playUtils,
    clickHome: (){
      msCon.clickHome();
    },
    clickResume: (){
      msCon.clickResume();
    },
    child: _listWidget(),
  );

  _listWidget()=>GetBuilder<MsP1Play20Con>(
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(0,0),
                  _cardWidget(0,1).marginOnly(left: 87.w),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(0,2),
                  _cardWidget(0,3).marginOnly(left: 87.w),
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
                  _cardWidget(1,1).marginOnly(left: 26.w),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,2),
                  _cardWidget(1,3).marginOnly(left: 26.w),
                ],
              ),
            ],
          ).marginOnly(top: 47.h),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cardWidget(2,0),
              SizedBox(height: 116.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(2,1),
                  _cardWidget(2,2).marginOnly(left: 87.w),
                ],
              )
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
        child: MsP1CardItemWidget(cardBean: bean),
      ),
    );
  }
}