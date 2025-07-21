enum WheelReardType{
  diamond,money
}

class MsWheelBean {
  int rewardNum;
  WheelReardType rewardType;
  MsWheelBean({
    required this.rewardNum,
    required this.rewardType,
});
}