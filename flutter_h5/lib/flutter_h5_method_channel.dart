import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_h5_platform_interface.dart';

/// An implementation of [FlutterH5Platform] that uses method channels.
class MethodChannelFlutterH5 extends FlutterH5Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_h5');

  @override
  Future<void> ms1A() async {
    await methodChannel.invokeMethod<String>('ms1');
  }
  @override
  Future<void> ms2B() async {
    await methodChannel.invokeMethod<String>('ms2');
  }
  @override
  Future<void> ms3B() async {
    await methodChannel.invokeMethod<String>('ms3');
  }
  @override
  Future<void> ms4H5() async {
    await methodChannel.invokeMethod<String>('ms4');
  }
}
