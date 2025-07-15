import 'dart:math';
import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MsP2WheelCon extends MsBaseCon with GetSingleTickerProviderStateMixin{
  var canClick=true;
  var addNum=MsP2ValueUtils.instance.getWheelReward();
  List<int> numList=[];
  late AnimationController _animationController;
  late Animation<double> animation;
  late AnimationStatusListener _statusListener;
  Function(double addNum)? dismissDialog;

  @override
  void onInit() {
    super.onInit();
    _initNumList();
  }

  _initNumList(){
    numList.clear();
    numList.add(addNum);
    numList.add(500);
    while(numList.length<8){
      numList.add(randomAroundNum(addNum));
    }
    numList.shuffle();
    var indexWhere = numList.indexWhere((value)=>value==addNum);
    if(indexWhere>=0){
      _initAnimator(360-indexWhere*45);
    }else{
      MsRouterUtils.instance.back();
    }
  }

  int randomAroundNum(int x) {
    final rnd = Random();
    if (x < 1) {
      return rnd.nextInt(3 - 1 + 1) + 1;
    } else {
      double lower = x * 0.8;
      double upper = x * 1.2;
      double randomValue = lower + rnd.nextDouble() * (upper - lower);
      return randomValue.round();
    }
  }

  _initAnimator(int angle){
    _animationController=AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    _statusListener=(status){
      if(status==AnimationStatus.completed){
        _animatorCompleted();
      }
    };
    _animationController.addStatusListener(_statusListener);
    animation=Tween<double>(begin: 0,end: (720+angle)*(pi/180)).animate(_animationController);
  }

  _animatorCompleted()async{
    await Future.delayed(Duration(milliseconds: 1000));
    MsRouterUtils.instance.back();
    dismissDialog?.call(addNum.toDouble());
  }

  startWheel(Function(double addNum) dismissDialog){
    if(!canClick){
      return;
    }
    canClick=false;
    this.dismissDialog=dismissDialog;
    _animationController.forward();
  }

  clickClose(Function(double addNum) dismissDialog){
    if(!canClick){
      return;
    }
    MsRouterUtils.instance.back();
    dismissDialog.call(0);
  }

  @override
  void onClose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_statusListener);
    super.onClose();
  }
}