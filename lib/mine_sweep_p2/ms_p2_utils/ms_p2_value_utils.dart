class MsP2ValueUtils{
  static final MsP2ValueUtils _utils=MsP2ValueUtils();
  static MsP2ValueUtils get instance => _utils;

  List<int> getCashList()=>[500,1000];

  //现金卡
  double getMoneyCardReward()=>0.5;
  //卡牌消除
  double getRemoveCardReward()=>0.5;
}