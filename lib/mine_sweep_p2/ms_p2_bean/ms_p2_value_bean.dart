import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';

class MsP2ValueBean {
  MsP2ValueBean({
      this.intAd, 
      this.cardEliminationReward, 
      this.cashCardReward, 
      this.wheelReward, 
      this.cardReward, 
      this.gemList, 
      this.gemReward,});

  MsP2ValueBean.fromJson(dynamic json) {
    if (json['int_ad'] != null) {
      intAd = [];
      json['int_ad'].forEach((v) {
        intAd?.add(IntAd.fromJson(v));
      });
    }
    if (json['card_elimination_reward'] != null) {
      cardEliminationReward = [];
      json['card_elimination_reward'].forEach((v) {
        cardEliminationReward?.add(CashCardReward.fromJson(v));
      });
    }
    if (json['cash_card_reward'] != null) {
      cashCardReward = [];
      json['cash_card_reward'].forEach((v) {
        cashCardReward?.add(CashCardReward.fromJson(v));
      });
    }
    if (json['wheel_reward'] != null) {
      wheelReward = [];
      json['wheel_reward'].forEach((v) {
        wheelReward?.add(CashCardReward.fromJson(v));
      });
    }
    if (json['card_reward'] != null) {
      cardReward = [];
      json['card_reward'].forEach((v) {
        cardReward?.add(CashCardReward.fromJson(v));
      });
    }
    if (json['gem_list'] != null) {
      gemList = [];
      json['gem_list'].forEach((v) {
        gemList?.add(GemList.fromJson(v));
      });
    }
    if (json['gem_reward'] != null) {
      gemReward = [];
      json['gem_reward'].forEach((v) {
        gemReward?.add(GemReward.fromJson(v));
      });
    }
  }
  List<IntAd>? intAd;
  List<CashCardReward>? cardEliminationReward;
  List<CashCardReward>? cashCardReward;
  List<CashCardReward>? wheelReward;
  List<CashCardReward>? cardReward;
  List<GemList>? gemList;
  List<GemReward>? gemReward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (intAd != null) {
      map['int_ad'] = intAd?.map((v) => v.toJson()).toList();
    }
    if (cardEliminationReward != null) {
      map['card_elimination_reward'] = cardEliminationReward?.map((v) => v.toJson()).toList();
    }
    if (cashCardReward != null) {
      map['cash_card_reward'] = cashCardReward?.map((v) => v.toJson()).toList();
    }
    if (wheelReward != null) {
      map['wheel_reward'] = wheelReward?.map((v) => v.toJson()).toList();
    }
    if (cardReward != null) {
      map['card_reward'] = cardReward?.map((v) => v.toJson()).toList();
    }
    if (gemList != null) {
      map['gem_list'] = gemList?.map((v) => v.toJson()).toList();
    }
    if (gemReward != null) {
      map['gem_reward'] = gemReward?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class GemList {
  GemList({
      this.num, 
      this.money,});

  GemList.fromJson(dynamic json) {
    num = json['num'];
    money = json['money'];
  }
  int? num;
  int? money;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['num'] = num;
    map['money'] = money;
    return map;
  }

}

class CashCardReward {
  CashCardReward({
      this.firstNumber,
      this.reward,
      this.endNumber,});

  CashCardReward.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    if(null!=json['reward']){
      reward=[];
      for(var value in json['reward']){
        reward?.add(value.toString().toDouble());
      }
    }
    endNumber = json['end_number'];
  }
  int? firstNumber;
  List<double>? reward;
  int? endNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['reward'] = reward;
    map['end_number'] = endNumber;
    return map;
  }

}

class IntAd {
  IntAd({
      this.firstNumber, 
      this.point, 
      this.endNumber,});

  IntAd.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    point = json['point'];
    endNumber = json['end_number'];
  }
  int? firstNumber;
  int? point;
  int? endNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['point'] = point;
    map['end_number'] = endNumber;
    return map;
  }

}

class GemReward {
  GemReward({
    this.firstNumber,
    this.point,
    this.reward,
    this.endNumber,});

  GemReward.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    point = json['point'];
    reward = json['reward'] != null ? json['reward'].cast<int>() : [];
    endNumber = json['end_number'];
  }
  int? firstNumber;
  int? point;
  List<int>? reward;
  int? endNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['point'] = point;
    map['reward'] = reward;
    map['end_number'] = endNumber;
    return map;
  }

}