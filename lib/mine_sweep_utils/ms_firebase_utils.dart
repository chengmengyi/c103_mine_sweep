import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class MsFirebaseUtils {
  static final MsFirebaseUtils _utils = MsFirebaseUtils();
  static MsFirebaseUtils get instance => _utils;

  FirebaseRemoteConfig? _remoteConfig;

  initFirebase()async{
    try{
      await Firebase.initializeApp();
      _remoteConfig=FirebaseRemoteConfig.instance;
      await _remoteConfig?.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      ));
      await _remoteConfig?.fetchAndActivate();
      _getFirebaseConfig();
    }catch(e){
      await Future.delayed(const Duration(milliseconds: 1000));
      initFirebase();
    }
  }

  _getFirebaseConfig(){
    var valueConfig = _remoteConfig?.getString("us_mineslt_numbers")??"";
    if(valueConfig.isNotEmpty&&valueFirebaseConfig.getData().isEmpty){
      valueFirebaseConfig.saveData(valueConfig);
      MsP2ValueUtils.instance.initValue();
    }
    var adConfig = _remoteConfig?.getString("ohqxn_ad_config")??"";
    if(adConfig.isNotEmpty){
      adFirebaseConfig.saveData(adConfig);
      MsAdUtils.instance.updateAdInfo();
    }
  }
}