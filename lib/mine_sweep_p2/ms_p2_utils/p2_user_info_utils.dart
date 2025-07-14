import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class P2UserInfoUtils{
  static final P2UserInfoUtils _utils = P2UserInfoUtils();
  static P2UserInfoUtils get instance => _utils;

  updateWheelPro(){
    p2WheelPro.saveData(p2WheelPro.getData()+1);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateWheelPro);

  }

  Widget? checkShowWheelDialog(){
    if(p2WheelPro.getData()>=5){

    }
    return null;
  }

  int getCurrentLevelNum(){
    var level = p2LevelNum.getData();
    int offset = (level - 1) % 20;
    if (offset < 10) {
      return offset + 1;
    } else {
      return offset + 1;
    }
  }

  String updateLevel(){
    updateDiamond(1);
    var nextLevel = _checkToNextLevelPage();
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateLevel);
    if(nextLevel>=0){
      return _getRouterNameByLevel(nextLevel);
    }else{
      return "";
    }
  }

  updateDiamond(int addNum){
    p2DiamondNum.saveData(p2DiamondNum.getData()+addNum);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateDiamond);
  }

  int _checkToNextLevelPage(){
    var currentLevel = p2LevelNum.getData();
    int nextLevel = currentLevel + 1;
    int currentStage = (currentLevel - 1) ~/ 10;
    int nextStage = (nextLevel - 1) ~/ 10;
    p2LevelNum.saveData(nextLevel);
    var isNext = currentStage != nextStage;
    if(isNext){
      return nextLevel;
    }else{
      return -1;
    }
  }


  String _getRouterNameByLevel(int nextLevel){
    var i = nextLevel%20;
    if(i<=10){
      return MsP2RoutersName.play10;
    }
    // else if(i<=20){
    //   return RoutersNameA.play11_20;
    // }
    return "";
  }

  updateCoinsNum(add){
    if(add==0){
      return;
    }
    var current = p2CoinsNum.getData();
    var result = (Decimal.parse("$current")+Decimal.parse("$add")).toDouble();
    p2CoinsNum.saveData(result);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateCoins,anyValue: add);
  }
}