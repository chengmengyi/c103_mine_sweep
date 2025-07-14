class MsP2CashTaskBean {
  MsP2CashTaskBean({
      this.cashTypeIndex, 
      this.cashAmount, 
      this.account, 
      this.cashTask, 
      this.currentPro, 
      this.totalPro,});

  MsP2CashTaskBean.fromJson(dynamic json) {
    cashTypeIndex = json['cashTypeIndex'];
    cashAmount = json['cashAmount'];
    account = json['account'];
    cashTask = json['cashTask'];
    currentPro = json['currentPro'];
    totalPro = json['totalPro'];
  }
  int? cashTypeIndex;
  int? cashAmount;
  String? account;
  String? cashTask;
  int? currentPro;
  int? totalPro;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cashTypeIndex'] = cashTypeIndex;
    map['cashAmount'] = cashAmount;
    map['account'] = account;
    map['cashTask'] = cashTask;
    map['currentPro'] = currentPro;
    map['totalPro'] = totalPro;
    return map;
  }

}