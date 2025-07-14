import 'dart:convert';
import 'dart:math';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_play_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension String2Color on String{
  Color toColor(){
    var hexStr = replaceAll("#", "");
    return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
  }
}

extension RandomList on List{
  random()=> this[Random().nextInt(length)];
}

showToast(String text) {
  if (text.isEmpty) {
    return;
  }
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16
  );
}

String getCardIcon({
  required String? cardText,
  required CardTypeEnum? cardTypeEnum,
}){
  return "${cardTypeEnum?.name}$cardText";
}

extension StringBase64 on String{
  String base64()=>const Utf8Decoder().convert(base64Decode(this));
}

double valuex2(value)=>(Decimal.parse("$value")*Decimal.fromInt(2)).toDouble();

extension String2Double on String{
  double toDouble(){
    try{
      return double.parse(this);
    }catch(e){
      return 0.0;
    }
  }
}
