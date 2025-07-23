import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play50/ms_p2_play50_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_base_play.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_card_item_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/scale_on_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2Play50Page extends MsBasePage<MsP2Play50Con>{
  @override
  MsP2Play50Con initMsCon() => MsP2Play50Con();

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
    clickCardCallback: (bean){
      msCon.clickCard(bean);
    },
    child: _listWidget(),
  );

  _listWidget()=>GetBuilder<MsP2Play50Con>(
    id: "list",
    builder: (_){
      if(msCon.p1playUtils.cardList.isEmpty){
        return Container();
      }
      return Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(0,0),
                  _cardWidget(0,1).marginOnly(left: 94.w),
                ],
              ),
              SizedBox(height: 111.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(0,2),
                  _cardWidget(0,3).marginOnly(left: 94.w),
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
                  _cardWidget(1,1).marginOnly(left: 27.w),
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,2),
                  _cardWidget(1,3).marginOnly(left: 12.w),
                  _cardWidget(1,4).marginOnly(left: 27.w),
                  _cardWidget(1,5).marginOnly(left: 12.w),
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,6),
                  _cardWidget(1,7).marginOnly(left: 12.w),
                  _cardWidget(1,8).marginOnly(left: 27.w),
                  _cardWidget(1,9).marginOnly(left: 12.w),
                ],
              ),
              SizedBox(height: 16.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,10),
                  _cardWidget(1,11).marginOnly(left: 27.w),
                ],
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cardWidget(2,0),
              SizedBox(height: 16.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(2,1),
                  _cardWidget(2,2).marginOnly(left: 12.w),
                  _cardWidget(2,3).marginOnly(left: 12.w),
                ],
              ),
              SizedBox(height: 16.h,),
              _cardWidget(2,4),
            ],
          ),
        ],
      );
    },
  );

  Widget _cardWidget(int fatherIndex,int childIndex){
    var bean = msCon.p1playUtils.cardList[fatherIndex][childIndex];
    return ScaleOnTap(
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