
import 'flutter_h5_platform_interface.dart';

class FlutterH5 {
  static final FlutterH5 _flutterH5=FlutterH5();
  static FlutterH5 get instance => _flutterH5;

  ms1A(){
    FlutterH5Platform.instance.ms1A();
  }
  ms2B(){
    FlutterH5Platform.instance.ms2B();
  }
  ms3B(){
    FlutterH5Platform.instance.ms3B();
  }
  ms4H5(){
    FlutterH5Platform.instance.ms4H5();
  }
}
