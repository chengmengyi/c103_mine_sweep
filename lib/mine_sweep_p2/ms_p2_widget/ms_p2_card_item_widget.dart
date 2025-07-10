import 'dart:math';

import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2CardItemWidget extends MsBaseStateful{
  MsP2CardBean cardBean;
  MsP2CardItemWidget({
    required this.cardBean,
});

  @override
  State<StatefulWidget> createState() => MsP2CardItemWidgetState();
}

class MsP2CardItemWidgetState extends MsBaseStatefulState<MsP2CardItemWidget> with SingleTickerProviderStateMixin{
  var _showFront=false;
  late AnimationController _cardItemController;

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget build(BuildContext context){
    if(!widget.cardBean.canShow){
      return SizedBox(width: 53.w,height: 79.h,);
    }
    return AnimatedBuilder(
      animation: _cardItemController,
      builder: (context, child) {
        double angle = _cardItemController.value * pi;
        bool isBack = angle > pi / 2;
        return Transform(
          transform: _getTransform(angle),
          alignment: Alignment.center,
          child: isBack ? _backgroundCardWidget(): _frontCardWidget(),
        );
      },
    );
  }

  _getTransform(angle)=>Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle);

  _getRotationY()=>Matrix4.rotationY(pi);

  _backgroundCardWidget()=> Transform(
    alignment: Alignment.center,
    transform: _getRotationY(),
    child: MsImages(imagesName: "card_background",width: 53.w,height: 79.h,),
  );

  _frontCardWidget()=>MsImages(
    imagesName: getCardIcon(cardText: widget.cardBean.cardText, cardTypeEnum: widget.cardBean.cardType),
    width: 53.w,
    height: 79.h,
  );

  _initAnimator(){
    _cardItemController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      value: 1.0,
    );
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.turnOverCard:
        if((event.anyValue as List<MsP2CardBean>).indexWhere((value)=>value.tag==widget.cardBean.tag)>=0){
          if(!_showFront){
            _cardItemController.reverse();
          }
          _showFront=true;
        }
        break;
    }
  }

  @override
  void dispose() {
    _cardItemController.dispose();
    super.dispose();
  }
}