import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsCardFingerGuideWidget extends MsBaseStateful{
  Function(MsP2CardBean bean) clickCardCallback;
  MsCardFingerGuideWidget({
    required this.clickCardCallback,
});
  @override
  State<StatefulWidget> createState() => MsCardFingerGuideWidgetState();
}

class MsCardFingerGuideWidgetState extends MsBaseStatefulState<MsCardFingerGuideWidget>{
  MsP2CardBean? msP2CardBean;
  Offset? offset;
  bool showHandsCardGuide=false;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Stack(
      children: [
        _getWidget(),
      ],
    ),
  );

  _getWidget(){
    if(showHandsCardGuide){
      return Positioned(
        bottom: 0,
        left: 30.w,
        child: MsClick(
          onTap: (){
            MsEventUtils.instance.sendMsg(code: MsP2EventCode.clickHandsCardFingerGuide);
          },
          child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
        ),
      );
    }
    if(null==msP2CardBean){
      return Container();
    }
    return Positioned(
      top: (offset?.dy??0)+30.h,
      left: (offset?.dx??0)+30.w,
      child: MsClick(
        onTap: (){
          widget.clickCardCallback.call(msP2CardBean!);
        },
        child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
      ),
    );
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.showCardFingerGuide:
        _showFingerGuide(event.anyValue as MsP2CardBean);
        break;
      case MsP2EventCode.showHandsCardFingerGuide:
        setState(() {
          showHandsCardGuide=true;
        });
        break;
      case MsP2EventCode.hideCardAndHandsFingerGuide:
        setState(() {
          showHandsCardGuide=false;
          msP2CardBean=null;
          offset=null;
        });
        break;
    }
  }

  _showFingerGuide(MsP2CardBean bean){
    msP2CardBean=bean;
    var renderBox = bean.globalKey.currentContext!.findRenderObject() as RenderBox;
    offset = renderBox.localToGlobal(Offset.zero);
    showHandsCardGuide=false;
    setState(() {});
  }
}