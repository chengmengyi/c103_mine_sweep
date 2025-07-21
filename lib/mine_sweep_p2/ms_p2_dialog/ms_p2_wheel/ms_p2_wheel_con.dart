import 'dart:math';
import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_wheel_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../mine_sweep_storage/p2/p2_storage.dart';
import '../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2WheelCon extends MsBaseCon with GetSingleTickerProviderStateMixin{
  var canClick=true;
  var addNum=MsP2ValueUtils.instance.getWheelReward();
  List<MsWheelBean> numList=[];
  late AnimationController _animationController;
  late Animation<double> animation;
  late AnimationStatusListener _statusListener;
  Function(MsWheelBean? bean)? dismissDialog;

  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.wheel_page,params: {"level":p2LevelNum.getData()});
    _initNumList();
  }

  _initNumList(){
    numList.clear();
    numList.add(MsWheelBean(rewardNum: addNum, rewardType: WheelReardType.money));
    numList.add(MsWheelBean(rewardNum: 500, rewardType: WheelReardType.money));
    var diamondReward = MsP2ValueUtils.instance.getDiamondReward();
    if(diamondReward>0){
      numList.add(MsWheelBean(rewardNum: diamondReward, rewardType: WheelReardType.diamond));
    }
    while(numList.length<8){
      numList.add(MsWheelBean(rewardNum: randomAroundNum(addNum), rewardType: WheelReardType.money));
    }
    numList.shuffle();
    var diamondIndex = numList.indexWhere((value)=>value.rewardType==WheelReardType.diamond);
    if(diamondIndex>=0){
      _initAnimator(360-diamondIndex*45);
      return;
    }
    var indexWhere = numList.indexWhere((value)=>value.rewardNum==addNum);
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
    var diamondIndex = numList.indexWhere((value)=>value.rewardType==WheelReardType.diamond);
    if(diamondIndex>=0){
      dismissDialog?.call(numList[diamondIndex]);
    }else{
      dismissDialog?.call(MsWheelBean(rewardNum: addNum, rewardType: WheelReardType.money));
    }
  }

  startWheel(Function(MsWheelBean? bean) dismissDialog){
    if(!canClick){
      return;
    }
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.wheel_page_c,params: {"level":p2LevelNum.getData()});
    canClick=false;
    this.dismissDialog=dismissDialog;
    _animationController.forward();
  }

  clickClose(Function(MsWheelBean? bean) dismissDialog){
    if(!canClick){
      return;
    }
    MsRouterUtils.instance.back();
    dismissDialog.call(null);
  }

  @override
  void onClose() {
    _animationController.dispose();
    _animationController.removeStatusListener(_statusListener);
    super.onClose();
  }
}