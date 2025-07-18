import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2HomeCashProWidget extends MsBaseStateful{
  Function() clickPlayCallback;
  MsP2HomeCashProWidget({
    required this.clickPlayCallback,
});
  
  @override
  State<StatefulWidget> createState() => MsP2HomeCashProWidgetState();
}
class MsP2HomeCashProWidgetState extends MsBaseStatefulState<MsP2HomeCashProWidget>{

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    height: 94.h,
    margin: EdgeInsets.only(left: 14.w,right: 14.w),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        MsImages(imagesName: "home12",width: double.infinity,height: double.infinity,),
        Row(
          children: [
            SizedBox(width: 14.w,),
            MsImages(imagesName: "home13",width: 44.w,height: 44.w,),
            SizedBox(width: 10.w,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textWidget(),
                  SizedBox(height: 8.h,),
                  _progressWidget(),
                ],
              ),
            ),
            SizedBox(width: 14.w,),
          ],
        )
      ],
    ),
  );

  _textWidget()=>Row(
    children: [
      Expanded(
        child: RichText(
          text: TextSpan(
            children: p2CoinsNum.getData()<MsP2ValueUtils.instance.getCashList().first?
            _getNoMoneyRichText():
            _getHasMoneyRichText(),
          ),
        ),
      ),
      SizedBox(width: 10.w,),
      MsClick(
        onTap: (){
          _clickBtn();
        },
        child: MsImages(imagesName: getPro()>=1?"home16":"home14",height: 33.h,boxFit: BoxFit.fitHeight,),
      )
    ],
  );

  _getNoMoneyRichText()=>[
    TextSpan(
      text: "🔥 Score ",
      style: TextStyle(
        color: "#912E00".toColor(),
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    TextSpan(
      text: "\$500",
      style: TextStyle(
        color: "#00AC22".toColor(),
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    TextSpan(
      text: " easily by playing games!",
      style: TextStyle(
        color: "#912E00".toColor(),
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];

  _getHasMoneyRichText()=>[
    TextSpan(
      text: "💰 ",
      style: TextStyle(
        color: "#912E00".toColor(),
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    TextSpan(
      text: "\$500",
      style: TextStyle(
        color: "#00AC22".toColor(),
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
    TextSpan(
      text: " Ready !Withdraw Instantly!",
      style: TextStyle(
        color: "#912E00".toColor(),
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  ];

  _progressWidget()=>Stack(
    alignment: Alignment.center,
    children: [
      Container(
        width: double.infinity,
        height: 10.h,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.w),
          color: "#D5D3C1".toColor(),
        ),
        child: ClipRect(
          child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: getPro(),
            child: MsImages(imagesName: "home15",width: double.infinity,height: 10.h,),
          ),
        ),
      ),
      MsText(text: "\$${p2CoinsNum.getData()}", size: 10.sp, color: "#FFFFFF",outLineColor: "#000000",)
    ],
  );

  double getPro(){
    var d = p2CoinsNum.getData()/MsP2ValueUtils.instance.getCashList().first;
    if(d<=0){
      return 0;
    }else if(d>=1){
      return 1;
    }else {
      return d;
    }
  }
  
  _clickBtn(){
    if(getPro()>=1){
      MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.home_page_withdraw);
      MsEventUtils.instance.sendMsg(code: MsP2EventCode.showHomeIndex,intValue: 1);
    }else{
      MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.home_page_start);
      widget.clickPlayCallback.call();
    }
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.updateCoins:
        setState(() {});
        break;
    }
  }
}