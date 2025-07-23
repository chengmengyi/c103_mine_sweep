import 'dart:math';

import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_pos_id.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_check_af/flutter_check_af.dart';
import 'package:get/get.dart';

class MsLaunchCon extends MsBaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController progressAnimationController;

  @override
  void onInit() {
    super.onInit();
    progressAnimationController=AnimationController(duration: const Duration(seconds: 10),vsync: this)
      ..addListener(() {
        update(["pro"]);
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          checkUserType();
        }
      });
    if(p2UserId.getData()==0){
      p2UserId.saveData(Random().nextInt(100000));
    }
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.launch_page);
  }

  @override
  void onReady() {
    super.onReady();
    if(!launchShowBtnCommon.getData()){
      progressAnimationController.forward();
    }
  }

  checkUserType(){
    launchShowBtnCommon.saveData(false);
    var user = FlutterCheckAf.instance.checkUser();
    if(kDebugMode){
      user=true;
    }
    if(user){
      if(showOpenAd.getData()){
        MsAdUtils.instance.showOpennnnAd(
          adType: AdType.interstitial,
          msAdPosId: MsAdPosId.ohqxn_launch,
          close: (){
            _toHome(user);
          },
        );
      }else{
        _toHome(user);
      }
    }else{
      _toHome(user);
    }
  }

  _toHome(bool user){
    showOpenAd.saveData(true);
    MsRouterUtils.instance.offNamed(routersName: user?MsP2RoutersName.home:MsP1RoutersName.home);
  }

  @override
  void onClose() {
    progressAnimationController.dispose();
    super.onClose();
  }
}