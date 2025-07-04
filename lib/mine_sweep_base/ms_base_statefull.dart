import 'dart:async';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:flutter/material.dart';

abstract class MsBaseStateful extends StatefulWidget{}

abstract class MsBaseStatefulState<K extends MsBaseStateful> extends State<K>{
  bool pageClosed=false;
  StreamSubscription<MsEventBean>? _streamSubscription;
  @override
  void initState() {
    super.initState();
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
  void dispose() {
    pageClosed=true;
    if(registerEvent()){
      _streamSubscription?.cancel();
      _streamSubscription=null;
    }
    super.dispose();
  }
}