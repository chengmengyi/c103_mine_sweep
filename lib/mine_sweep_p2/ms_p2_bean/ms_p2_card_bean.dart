import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_play_utils.dart';
import 'package:flutter/material.dart';

class MsP2CardBean {
  int tag;
  String cardText;
  bool isTopCard;
  bool isCoveredCard;
  bool canShow;
  CardTypeEnum cardType;
  GlobalKey globalKey;
  bool isMoneyCard;

  MsP2CardBean({
    required this.tag,
    required this.cardText,
    required this.isTopCard,
    required this.isCoveredCard,
    required this.canShow,
    required this.cardType,
    required this.globalKey,
    this.isMoneyCard=false,
  });

  @override
  String toString() {
    return 'MsP2CardBean{cardText: $cardText, isTopCard: $isTopCard, isCoveredCard: $isCoveredCard, canShow: $canShow, cardType: $cardType}';
  }
}
