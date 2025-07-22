import 'dart:async';

import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_pos_id.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_app_lifecycle/app_state_observer.dart';
import 'package:flutter_app_lifecycle/flutter_app_lifecycle.dart';

class MsAppLifeUtils {

  static final MsAppLifeUtils _utils = MsAppLifeUtils();
  static MsAppLifeUtils get instance => _utils;

  Timer? _timer;
  var _isBack=false;

  setCallObserver(){
    FlutterAppLifecycle.instance.setCallObserver(
      AppStateObserver(
        call: (back){
          if(back){
            MsVoiceUtils.instance.pauseBgMusic();
            _startTimer();
          }else{
            MsVoiceUtils.instance.resumeBgMusic();
            _endTimer();
          }
        },
      ),
    );
  }

  _startTimer(){
    _timer=Timer(const Duration(milliseconds: 3000), () {
      _isBack=true;
    });
  }

  _endTimer(){
    MsTbaUtils.instance.sessionEvent();
    _timer?.cancel();
    Future.delayed(const Duration(milliseconds: 100),(){
      if(_isBack&&!FlutterIosAdHep.instance.adShowing()){
        MsAdUtils.instance.showOpennnnAd(adType: AdType.interstitial, msAdPosId: MsAdPosId.ohqxn_launch, close: (){});
      }
      _isBack=false;
    });
  }
}