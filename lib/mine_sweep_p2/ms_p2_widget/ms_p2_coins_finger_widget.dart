import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2CoinsFingerWidget extends MsBaseStateful{
  bool fromHome;
  GlobalKey globalKey;
  MsP2CoinsFingerWidget({required this.globalKey,required this.fromHome});

  @override
  State<StatefulWidget> createState() => MsP2CoinsFingerWidgetState();
}

class MsP2CoinsFingerWidgetState extends MsBaseStatefulState<MsP2CoinsFingerWidget>{
  Offset? offset;

  @override
  void initState() {
    super.initState();
    Future((){
      var renderBox = widget.globalKey.currentContext!.findRenderObject() as RenderBox;
      offset=renderBox.localToGlobal(Offset.zero);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Stack(
      children: [
        Positioned(
          top: offset?.dy??0,
          left: (offset?.dx??0)+50.w,
          child: Visibility(
            visible: p2ShowCoinsFinger.getData()&&p2CoinsNum.getData()>=MsP2ValueUtils.instance.getCashList().first,
            child: MsClick(
              onTap: (){
                if(!widget.fromHome){
                  MsRouterUtils.instance.back();
                }
                p2ShowCoinsFinger.saveData(false);
                MsEventUtils.instance.sendMsg(code: MsP2EventCode.showHomeIndex,intValue: 1);
                setState(() {});
              },
              child: MsLottieWidget(lottieName: "finger",width: 60.w,height: 65.h,),
            ),
          ),
        )
      ],
    ),
  );

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