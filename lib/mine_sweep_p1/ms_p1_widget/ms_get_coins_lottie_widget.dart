import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsGetCoinsLottieWidget extends MsBaseStateful{
  @override
  State<StatefulWidget> createState() => MsGetCoinsLottieWidgetState();
}
class MsGetCoinsLottieWidgetState extends MsBaseStatefulState<MsGetCoinsLottieWidget> with TickerProviderStateMixin{
  var show=false;
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();
    lottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 900))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        show=false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!show){
      return Container();
    }
    return MsLottieWidget(
      lottieName: "coins",
      ext: "zip",
      repeat: false,
      animationController: lottieController,
    ).marginOnly(top: 80.h);
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP1EventCode.updateCoins:
        if((event.intValue??0)<=0){
          return;
        }
        show=true;
        setState(() {});
        lottieController..reset()..forward();
        break;
    }
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }
}