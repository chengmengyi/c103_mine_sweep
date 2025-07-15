import 'dart:convert';
import 'dart:math';

import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_value_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_local_info.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';

class MsP2ValueUtils{
  static final MsP2ValueUtils _utils=MsP2ValueUtils();
  static MsP2ValueUtils get instance => _utils;

  MsP2ValueBean? _p2valueBean;

  initValue(){
    try{
      _p2valueBean=MsP2ValueBean.fromJson(jsonDecode(MsLocalInfo.valueStr.base64()));
    }catch(e){
      _p2valueBean=MsP2ValueBean.fromJson(jsonDecode(MsLocalInfo.valueStr.base64()));
    }
  }

  List<int> getCashList()=>[500,1000];

  //现金卡
  double getMoneyCardReward()=>0.5;
  //卡牌消除
  double getRemoveCardReward()=>0.5;
  //翻卡增加
  double getCardGamesReward()=>0.5;
  //转盘增加
  int getWheelReward()=>5;

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

  double _getRandomDoubleInRange(int min, int max) {
    final random = Random();
    final value = min + (max - min) * random.nextDouble();
    return double.parse(value.toStringAsFixed(2));
  }
}