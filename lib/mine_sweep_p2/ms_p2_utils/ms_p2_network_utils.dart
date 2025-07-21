import 'dart:async';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_check_af_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_firebase_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MsP2NetworkUtils {
  static final MsP2NetworkUtils _utils=MsP2NetworkUtils();
  static MsP2NetworkUtils get instance => _utils;

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  setNetworkListener(){
    _subscription=Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(result.contains(ConnectivityResult.mobile)||result.contains(ConnectivityResult.wifi)){
        MsFirebaseUtils.instance.initFirebase();
        MsCheckAfUtils.instance.init();
        cancelSubscription();
      }
    });
  }

  Future<bool> checkHasNetwork()async{
    List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult.contains(ConnectivityResult.mobile)||connectivityResult.contains(ConnectivityResult.wifi);
  }

  cancelSubscription(){
    _subscription?.cancel();
  }
}