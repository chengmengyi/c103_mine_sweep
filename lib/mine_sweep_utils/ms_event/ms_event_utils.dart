import 'dart:async';

import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:event_bus/event_bus.dart';

class MsEventUtils {
  static final MsEventUtils _utils = MsEventUtils();
  static MsEventUtils get instance => _utils;

  final EventBus _event=EventBus();

  sendMsg({
    required int code,
    int? intValue,
    dynamic anyValue,
}){
    _event.fire(MsEventBean(code: code,intValue: intValue,anyValue: anyValue));
  }

  StreamSubscription<MsEventBean> registerEvent({required Function(MsEventBean bean) callback}){
    return _event.on<MsEventBean>().listen((event) {
      callback.call(event);
    });
  }
}