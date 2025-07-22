import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_pos_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:get/get.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';

import '../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2TornadoCon extends MsBaseCon with GetSingleTickerProviderStateMixin{
  late AnimationController _boxController;
  late Animation<double> boxScaleAnimation;
  ShakeAnimationController shakeAnimationController=ShakeAnimationController();

  @override
  void onInit() {
    super.onInit();
    _initAnimator();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.tomato_page,);
  }

  @override
  void onReady() {
    super.onReady();
    _boxController.repeat(reverse: true);
  }

  // clickCoins(Function() getWildCallback){
  //   if(p2CoinsNum.getData()<2000){
  //     shakeAnimationController.start();
  //     return;
  //   }
  //   P2UserInfoUtils.instance.updateCoinsNum(-2000);
  //   MsRouterUtils.instance.back();
  //   getWildCallback.call();
  // }

  clickVideo(Function() getWildCallback){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.tomato_collect_c,);
    MsAdUtils.instance.showP2222Ad(
      adType: AdType.reward,
      msAdPosId: MsAdPosId.ohqxn_tornado_rv,
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