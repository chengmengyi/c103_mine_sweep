import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/p1_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:get/get.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

class MsP1TornadoCon extends MsBaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController _boxController;
  late Animation<double> boxScaleAnimation;
  ShakeAnimationController shakeAnimationController=ShakeAnimationController();

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
  }

  @override
  void onReady() {
    super.onReady();
    _boxController.repeat(reverse: true);
  }

  clickCoins(Function() getWildCallback){
    if(p1CoinsNum.getData()<1000){
      shakeAnimationController.start();
      return;
    }
    P1UserInfoUtils.instance.updateCoinsNum(-1000);
    MsRouterUtils.instance.back();
    getWildCallback.call();
  }

  clickVideo(Function() getWildCallback){
    MsAdUtils.instance.showP111111Ad(
      adType: AdType.reward,
      close: (){
        MsRouterUtils.instance.back();
        getWildCallback.call();
      },
    );
  }

  clickClose(){
    MsRouterUtils.instance.back();
  }


  _initAnimator(){
    _boxController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    boxScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _boxController, curve: Curves.easeInOut),
    );
  }

  @override
  void onClose() {
    _boxController.dispose();
    super.onClose();
  }
}