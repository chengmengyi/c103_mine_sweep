import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class MsP2WheelProWidget extends MsBaseStateful{
  @override
  State<StatefulWidget> createState() => MsP2WheelProWidgetState();
}

class MsP2WheelProWidgetState extends MsBaseStatefulState<MsP2WheelProWidget>{
  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 85.h,
    margin: EdgeInsets.only(left: 12.w,right: 12.w,),
    child: Stack(
      children: [
        MsImages(imagesName: "play1",width: double.infinity,height: 85.h,),
        _wheelProgressWidget(),
        _levelWidget(),
      ],
    ),
  );

  _wheelProgressWidget()=>Align(
    alignment: Alignment.topCenter,
    child: Row(
      children: [
        SizedBox(width: 15.w,),
        Expanded(
          child: SizedBox(
            width: double.infinity,
            height: 18.h,
            child: MasonryGridView.count(
              itemCount: 5,
              crossAxisCount: 5,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 0,
              crossAxisSpacing: 4.w,
              itemBuilder: (context,index){
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    MsImages(imagesName: "play2",width: double.infinity,height: 18.h,),
                    Visibility(
                      visible: p2WheelPro.getData()>index,
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.w,right: 2.w),
                        child: MsImages(imagesName: "play4",width: double.infinity,height: 14.h,),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(width: 6.w,),
        MsImages(imagesName: p2LastShowWheel.getData()?"play5":"play3",width: 46.w,height: 52.h,),
        SizedBox(width: 6.w,),
      ],
    ).marginOnly(top: 6.h),
  );
  
  _levelWidget()=>Align(
    alignment: Alignment.bottomCenter,
    child: MsText(text: "LEVEL ${P2UserInfoUtils.instance.getCurrentLevelNum()}", size: 14.sp, color: "#FFFFFF",outLineColor: "#3F0000",).marginOnly(bottom: 6.h),
  );

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.updateCoins:
      case MsP2EventCode.updateLevel:
      case MsP2EventCode.updateWheelPro:
        setState(() {});
        break;
    }
  }
}