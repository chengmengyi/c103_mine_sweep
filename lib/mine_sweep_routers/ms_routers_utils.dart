
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MsRouterUtils{
  static final MsRouterUtils _utils = MsRouterUtils();
  static MsRouterUtils get instance => _utils;

  showDialog({required Widget child,dynamic arguments, bool? barrierDismissible, Color? bc}){
    Get.dialog(
      child,
      arguments: arguments,
      barrierColor: bc,
      barrierDismissible: barrierDismissible ?? false,
    );
  }

  offNamed({required String routersName}){
    Get.offNamed(routersName);
  }

  offAllNamed({required String routersName}){
    Get.offAllNamed(routersName);
  }


  offAllUnit({required String routersName}){
    Get.until((route) => route.settings.name==routersName);
  }

  back(){
    Get.back();
  }

  toNamed({required String routersName,Map<String, dynamic>? arguments})async{
    Get.toNamed(routersName,arguments: arguments);
  }

  Map<String, dynamic> getArguments() {
    try {
      return Get.arguments as Map<String, dynamic>;
    } catch (e) {
      return {};
    }
  }
}