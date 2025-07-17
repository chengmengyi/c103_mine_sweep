import 'package:connectivity_plus/connectivity_plus.dart';

class MsP2NetworkUtils {
  static final MsP2NetworkUtils _utils=MsP2NetworkUtils();
  static MsP2NetworkUtils get instance => _utils;

  Future<bool> checkHasNetwork()async{
    List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.contains(ConnectivityResult.mobile)||connectivityResult.contains(ConnectivityResult.wifi);
  }
}