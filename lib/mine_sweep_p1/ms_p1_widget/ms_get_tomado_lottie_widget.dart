import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_bean/ms_p1_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsGetTomadoLottieWidget extends MsBaseStateful{
  @override
  State<StatefulWidget> createState() => MsGetTomadoLottieWidgetState();
}
class MsGetTomadoLottieWidgetState extends MsBaseStatefulState<MsGetTomadoLottieWidget> with TickerProviderStateMixin{
  var show=false;
  List<MsP1CardBean> cardList=[];
  late AnimationController lottieController;

  @override
  void initState() {
    super.initState();
    lottieController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1000))..addStatusListener((status) {
      if(status==AnimationStatus.completed){
        show=false;
        setState(() {});
        MsEventUtils.instance.sendMsg(code: MsP1EventCode.startTornadoAnimator,anyValue: cardList);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if(!show){
      return Container();
    }
    return Center(
      child: MsLottieWidget(
        lottieName: "bao",
        ext: "zip",
        repeat: false,
        animationController: lottieController,
      ),
    );
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP1EventCode.startBaozhaLottie:
        cardList.clear();
        cardList.addAll(event.anyValue as List<MsP1CardBean>);
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