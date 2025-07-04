import 'dart:async';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MsBaseCon extends GetxController{
  late BuildContext context;
  bool pageClosed=false;
  StreamSubscription<MsEventBean>? _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    if(registerEvent()){
      _streamSubscription=MsEventUtils.instance.registerEvent(
        callback: (event){
          handleEventMessage(event);
        },
      );
    }
  }

  bool registerEvent() => false;

  handleEventMessage(MsEventBean event){}

  @override
  void onClose() {
    pageClosed=true;
    if(registerEvent()){
      _streamSubscription?.cancel();
      _streamSubscription=null;
    }
    super.onClose();
  }
}