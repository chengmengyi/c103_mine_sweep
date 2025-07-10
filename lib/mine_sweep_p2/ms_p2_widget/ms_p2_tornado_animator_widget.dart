import 'dart:math';

import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP2TornadoAnimatorWidget extends MsBaseStateful{
  @override
  State<StatefulWidget> createState() => MsP2TornadoAnimatorWidgetState();
}

class MsP2TornadoAnimatorWidgetState extends MsBaseStatefulState<MsP2TornadoAnimatorWidget> with SingleTickerProviderStateMixin{
  List<MsP2CardBean> list=[];
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _rotationAnimation;
  late AnimationStatusListener _statusListener;

  @override
  void initState() {
    super.initState();
    _initAnimator();
  }

  @override
  Widget build(BuildContext context) {
    if(list.isEmpty){
      return Container();
    }
    return  AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => _getBuilder(context,child),
      child: Stack(
        children: _getCardListWidget(),
      ),
    );
  }

  _getBuilder(context, child)=>Transform.translate(
    offset: _getOffset(context),
    child: _getBuilderChild(child),
  );

  Offset _getOffset(context)=> _offsetAnimation.value * MediaQuery.of(context).size.width;

  _getBuilderChild(child)=>Transform.rotate(
    angle: _rotationAnimation.value * 2 * pi * 2,
    child: Opacity(
      opacity: _opacityAnimation.value,
      child: child,
    ),
  );

  _getCardListWidget()=> list.map((bean){
    var renderBox = bean.globalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    return Positioned(
      top: offset.dy,
      left: offset.dx,
      child: MsImages(
        imagesName: getCardIcon(cardText: bean.cardText, cardTypeEnum: bean.cardType),
        width: 53.w,
        height: 79.h,
      ),
    );
  }).toList();

  _initAnimator(){
    _initController();
    _initOpacity();
    _initOffset();
    _initRotation();
    _initStatus();
    _controller.addStatusListener(_statusListener);
  }

  _initController(){
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
  }

  _initOpacity(){
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }
  _initOffset(){
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(2.0, -2.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }
  _initRotation(){
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
  }

  _initStatus(){
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        P2UserInfoUtils.instance.updateCoinsNum(100*list.length);
        setState(() {
          list.clear();
        });
      }
    };
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.startTornadoAnimator:
        _startTornadoAnimator(event);
        break;
    }
  }

  _startTornadoAnimator(MsEventBean event){
    var list = event.anyValue as List<MsP2CardBean>;
    setState(() {
      this.list.clear();
      this.list.addAll(list);
    });
    _controller..reset()..forward();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }
}