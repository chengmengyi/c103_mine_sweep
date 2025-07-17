import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play80/ms_p2_play80_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_base_play.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_card_item_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2Play80Page extends MsBasePage<MsP2Play80Con>{
  @override
  MsP2Play80Con initMsCon() => MsP2Play80Con();

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

  _listWidget()=>GetBuilder<MsP2Play80Con>(
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
              _cardWidget(0,0),
              SizedBox(height: 173.h,),
              _cardWidget(0,1),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,0),
                  _cardWidget(1,1).marginOnly(left: 4.w),
                  _cardWidget(1,2).marginOnly(left: 4.w),
                ],
              ),
              SizedBox(height: 102.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(1,3),
                  _cardWidget(1,4).marginOnly(left: 4.w),
                  _cardWidget(1,5).marginOnly(left: 4.w),
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
                  _cardWidget(2,0),
                  _cardWidget(2,1).marginOnly(left: 4.w),
                  _cardWidget(2,2).marginOnly(left: 4.w),
                  _cardWidget(2,3).marginOnly(left: 4.w),
                  _cardWidget(2,4).marginOnly(left: 4.w),
                ],
              ),
              SizedBox(height: 22.h,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _cardWidget(2,5),
                  _cardWidget(2,6).marginOnly(left: 4.w),
                  _cardWidget(2,7).marginOnly(left: 4.w),
                  _cardWidget(2,8).marginOnly(left: 4.w),
                  _cardWidget(2,9).marginOnly(left: 4.w),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _cardWidget(3,0),
              _cardWidget(3,1).marginOnly(left: 4.w),
              _cardWidget(3,2).marginOnly(left: 4.w),
              _cardWidget(3,3).marginOnly(left: 4.w),
              _cardWidget(3,4).marginOnly(left: 4.w),
              _cardWidget(3,5).marginOnly(left: 4.w),
              _cardWidget(3,6).marginOnly(left: 4.w),
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
        child: MsP2CardItemWidget(
          cardBean: bean,
          width: 50.w,
          height: 77.h,
        ),
      ),
    );
  }
}