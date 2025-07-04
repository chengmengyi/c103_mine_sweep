import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_bean/ms_p1_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP1CardMoveAnimatorWidget extends MsBaseStateful{
  @override
  State<StatefulWidget> createState() => MsP1CardMoveAnimatorWidgetState();
}

class MsP1CardMoveAnimatorWidgetState extends MsBaseStatefulState<MsP1CardMoveAnimatorWidget> with TickerProviderStateMixin{
  MsP1CardBean? cardBean;
  Animation<Offset>? moveAnimation;
  late AnimationController moveController;

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget build(BuildContext context) {
    if(null==cardBean){
      return Container();
    }
    var value = moveAnimation?.value;
    var dx = value?.dx??0;
    var dy = value?.dy??0;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: dx<=0?0:dx,top: dy<=0?0:dy),
          child: MsImages(imagesName: getCardIcon(cardText: cardBean?.cardText, cardTypeEnum: cardBean?.cardType),width: 53.w,height: 79.h,),
        ),
      ],
    );
  }

  _initAnimator(){
    moveController=AnimationController(vsync: this,duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          setState(() {
            cardBean=null;
          });
        }
      });
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP1EventCode.cardMoveAnimator:
        _startCardMoveAnimator(event);
        break;
    }
  }

  _startCardMoveAnimator(MsEventBean event){
    var map = event.anyValue as Map;
    cardBean=map["bean"];
    setState(() {});
    moveAnimation=Tween<Offset>(
      begin: map["cardOffset"],
      end: map["pointOffset"],
    ).animate(CurvedAnimation(parent: moveController, curve: Curves.easeInOut));

    moveController..reset()..forward();
  }

  @override
  void dispose() {
    moveController.dispose();
    super.dispose();
  }
}