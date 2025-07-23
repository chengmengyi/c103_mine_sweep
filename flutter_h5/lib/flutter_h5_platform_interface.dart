import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_h5_method_channel.dart';

abstract class FlutterH5Platform extends PlatformInterface {
  /// Constructs a FlutterH5Platform.
  FlutterH5Platform() : super(token: _token);

  static final Object _token = Object();

  static FlutterH5Platform _instance = MethodChannelFlutterH5();

  /// The default instance of [FlutterH5Platform] to use.
  ///
  /// Defaults to [MethodChannelFlutterH5].
  static FlutterH5Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterH5Platform] when
  /// they register themselves.
  static set instance(FlutterH5Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> ms1A() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> ms2B() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> ms3B() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<void> ms4H5() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
