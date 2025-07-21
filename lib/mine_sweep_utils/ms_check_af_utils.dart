import 'dart:io';

import 'package:c103_mine_sweep/mine_sweep_utils/ms_local_info.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:flutter_check_af/request_af/request_af_callback.dart';
import 'package:flutter_check_af/request_cloak/request_cloak_callback.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class MsCheckAfUtils {
  static final MsCheckAfUtils _utils=MsCheckAfUtils();
  static MsCheckAfUtils get instance => _utils;

  Function()? _p1PageCallback;

  init()async{
    var distinctId = await FlutterTbaInfo.instance.getDistinctId();
    FlutterCheckAf.instance.init(
      afKey: MsLocalInfo.afKeyBase64.base64(),
      afAppId: MsLocalInfo.afAppidBase64.base64(),
      afSwitch: "1",
      distinctId: distinctId,
      clockUrl: "https://posh.minesweepsolitaire.com/myers/demitted/bible",
      cloakWhiteKey: "impasse",
      cloakData: await _getCloakMMap(distinctId),
      requestAfCallback: RequestAfCallback(
        startRequestAf: () {  },
        requestSuccess: (bool isB) {
          _checkUserType();
        },
        firstRequestAfB: () {  },
        startAfSuccess: () {  },
        startAfFail: (int code, String msg) {  },
      ),
      requestCloakCallback: RequestCloakCallback(
        startRequestCloak: (){
        },
        requestSuccess: (bool isWhite){
          _checkUserType();
        },
      ),
    );
  }

  _checkUserType(){
    if(FlutterCheckAf.instance.checkUser()){
      _p1PageCallback?.call();
      _p1PageCallback=null;
    }
  }

  setP1PageCallback(Function() call){
    _p1PageCallback=call;
  }

  Future<Map<String,dynamic>> _getCloakMMap(String distinctId)async{
    return {
      "fantod": await FlutterTbaInfo.instance.getBundleId(),
      "funny": Platform.isAndroid?"show":"adjourn",
      "oedipus": await FlutterTbaInfo.instance.getAppVersion(),
      "hull": distinctId,
      "corrode": DateTime.now().millisecondsSinceEpoch,
      "mutt": await FlutterTbaInfo.instance.getDeviceModel(),
      "pave": await FlutterTbaInfo.instance.getOsVersion(),
      "allege": await FlutterTbaInfo.instance.getIdfv(),
      "songbag": await FlutterTbaInfo.instance.getGaid(),
      "suffuse": await FlutterTbaInfo.instance.getAndroidId(),
      "dwarves": await FlutterTbaInfo.instance.getIdfa(),
    };
  }
}