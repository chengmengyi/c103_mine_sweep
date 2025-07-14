import 'dart:math';
import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MsP2CardGameItemWidget extends MsBaseStateful{
  int index;
  double addNum;
  Function() clickCardCallback;
  MsP2CardGameItemWidget({
    required this.index,
    required this.addNum,
    required this.clickCardCallback,
  });

  @override
  State<StatefulWidget> createState() => MsP2CardGameItemWidgetState();
}

class MsP2CardGameItemWidgetState extends MsBaseStatefulState<MsP2CardGameItemWidget> with SingleTickerProviderStateMixin {
  var otherAddNum=0.0,clickIndex=-1;
  late AnimationController _cardController;
  late Animation<double> _cardAnimation;
  bool showFront = false,canClickCard=true,flipOtherCard=false,showMissIcon=false;

  @override
  void initState() {
    super.initState();
    otherAddNum = _randomReduce(widget.addNum);
    _initAnimator();
  }

  @override
  Widget build(BuildContext context) => MsClick(
    onTap: (){
      if (_cardController.isAnimating||!canClickCard){
        return;
      }
      canClickCard=false;
      MsEventUtils.instance.sendMsg(code: MsP2EventCode.startFlipClickCard);
      setState(() {
        clickIndex=widget.index;
        flipOtherCard=true;
      });
      _cardController.forward();
      widget.clickCardCallback.call();
    },
    child: AnimatedBuilder(
      animation: _cardAnimation,
      builder: (context, child) {
        final angle = _cardAnimation.value * pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(angle);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: Opacity(
            opacity: angle <= pi / 2 ? 1 : 0,
            child: showFront ?
            _frontWidget() :
            Transform(
              transform: Matrix4.identity()..rotateY(3.1415926),
              alignment: Alignment.center,
              child: _backgroundWidget(),
            ),
          ),
        );
      },
    ),
  );

  _frontWidget()=>Stack(
    alignment: Alignment.bottomCenter,
    children: [
      MsImages(imagesName: "card_game3",width: double.infinity,height: 106.h,),
      MsText(text: "+\$${widget.index==clickIndex?widget.addNum:otherAddNum}", size: 16.sp, color: "#009407",useFontFamily: false,fontWeight: FontWeight.bold,).marginOnly(bottom: 20.h),
    ],
  );

  _backgroundWidget()=>MsImages(imagesName: "card_game2",width: double.infinity,height: 106.h,);

  double _randomReduce(double value) {
    final rand = Random();
    double factor = rand.nextDouble() * 0.8 + 0.2;
    return (value * factor).toStringAsFixed(3).toDouble();
  }

  _initAnimator(){
    _cardController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _cardAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _cardController,
        curve: Curves.easeInOut,
      ),
    );
    _cardController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          showFront=!showFront;
        });
        _cardController.reverse();
        if(flipOtherCard){
          MsEventUtils.instance.sendMsg(code: MsP2EventCode.flipOtherCards,intValue: widget.index);
        }
      }
    });
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.flipOtherCards:
        _flipOtherCard(event);
        break;
      case MsP2EventCode.startFlipClickCard:
        canClickCard=false;
        break;
    }
  }

  _flipOtherCard(MsEventBean event)async{
    if(event.intValue==widget.index){
      return;
    }
    await Future.delayed(Duration(milliseconds: 800));
    _cardController.forward();
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }
}