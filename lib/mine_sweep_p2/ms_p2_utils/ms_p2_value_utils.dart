import 'dart:convert';
import 'dart:math';

import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_value_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_local_info.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';

class MsP2ValueUtils{
  static final MsP2ValueUtils _utils=MsP2ValueUtils();
  static MsP2ValueUtils get instance => _utils;

  MsP2ValueBean? _p2valueBean;

  initValue(){
    try{
      var value=MsLocalInfo.valueStr.base64();
      if(valueFirebaseConfig.getData().isNotEmpty){
        value=valueFirebaseConfig.getData();
      }
      if(kDebugMode){
        value=MsLocalInfo.valueStr.base64();
      }
      _p2valueBean=MsP2ValueBean.fromJson(jsonDecode(value));
    }catch(e){
      _p2valueBean=MsP2ValueBean.fromJson(jsonDecode(MsLocalInfo.valueStr.base64()));
    }
  }

  List<int> getCashList()=>[500,1000];

  //现金卡
  double getMoneyCardReward()=>_getReward(_p2valueBean?.cashCardReward??[]);
  //卡牌消除
  double getRemoveCardReward()=>_getReward(_p2valueBean?.cardEliminationReward??[]);
  //翻卡增加
  double getCardGamesReward()=>_getReward(_p2valueBean?.cardReward??[]);
  //转盘增加
  int getWheelReward()=>_getReward(_p2valueBean?.wheelReward??[]).toInt();
  //宝石增加
  int getDiamondReward(){
    if(kDebugMode){
    return 1;
    }
    var list = _p2valueBean?.gemReward??[];
    if(list.isEmpty){
      return 0;
    }
    var coinsNum = p2CoinsNum.getData();
    var last = list.last;
    if(coinsNum>=(last.endNumber??200)){
      var reward = last.reward??[];
      if(reward.isEmpty){
        return 0;
      }
      if(Random().nextInt(100)>=(last.point??50)){
        return 0;
      }
      if(reward.length==1){
        return reward.first;
      }
      return randomIntInRange(reward.first,reward.last);
    }
    for (var value in list) {
      if(coinsNum>=(value.firstNumber??0)&&coinsNum<(value.endNumber??0)){
        var reward = value.reward??[];
        if(reward.isEmpty){
          return 0;
        }
        if(Random().nextInt(100)>=(last.point??50)){
          return 0;
        }
        if(reward.length==1){
          return reward.first;
        }
        return randomIntInRange(reward.first,reward.last);
      }
    }
    return 0;
  }

  List<GemList> getDiamondList()=>_p2valueBean?.gemList??[];

  bool showAd(AdType adType){
    if(kDebugMode){
      return false;
    }
    if(adType==AdType.reward){
      return true;
    }
    var intAd = _p2valueBean?.intAd??[];
    if(intAd.isEmpty){
      return false;
    }
    var coinsNum = p2CoinsNum.getData();
    var last = intAd.last;
    if(coinsNum>=(last.endNumber??200)){
      return Random().nextInt(100)<(last.point??100);
    }
    for (var value in intAd) {
      if(coinsNum>=(value.firstNumber??0)&&coinsNum<(value.endNumber??0)){
        return Random().nextInt(100)<(value.point??50);
      }
    }
    return false;
  }

  double _getReward(List<CashCardReward> list){
    if(list.isEmpty){
      return 0.01;
    }
    var coinsNum = p2CoinsNum.getData();
    var last = list.last;
    if(coinsNum>=(last.endNumber??200)){
      var reward = last.reward??[];
      if(reward.isEmpty){
        return 0.01;
      }
      if(reward.length==1){
        return reward.first.toDouble();
      }
      return _getRandomDoubleInRange(reward.first,reward.last);
    }
    for (var value in list) {
      if(coinsNum>=(value.firstNumber??0)&&coinsNum<(value.endNumber??0)){
        var reward = value.reward??[];
        if(reward.isEmpty){
          return 0.0001;
        }
        if(reward.length==1){
          return reward.first.toDouble();
        }
        return _getRandomDoubleInRange(reward.first,reward.last);
      }
    }
    return 0.01;
  }

  double _getRandomDoubleInRange(double min, double max) {
    final random = Random();
    final value = min + (max - min) * random.nextDouble();
    return double.parse(value.toStringAsFixed(2));
  }

  int randomIntInRange(int min, int max) {
    final random = Random();
    return random.nextInt(max - min + 1) + min;
  }
}