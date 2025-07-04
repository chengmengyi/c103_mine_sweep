import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
import 'package:flutter/material.dart';
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
          toHome();
        }
      });
  }

  @override
  void onReady() {
    super.onReady();
    if(!launchShowBtnCommon.getData()){
      progressAnimationController.forward();
    }
  }

  toHome(){
    launchShowBtnCommon.saveData(false);
    MsRouterUtils.instance.offNamed(routersName: MsP1RoutersName.home);
  }

  @override
  void onClose() {
    progressAnimationController.dispose();
    super.onClose();
  }
}