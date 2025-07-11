import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlined_text/outlined_text.dart';

class MsText extends StatelessWidget{
  String text;
  double size;
  String color;
  String? outLineColor;
  String? decorationColor;
  TextDecoration? decoration;
  double? withOpacity;
  bool? useFontFamily;
  FontWeight? fontWeight;

  MsText({
    required this.text,
    required this.size,
    required this.color,
    this.outLineColor,
    this.decoration,
    this.decorationColor,
    this.withOpacity,
    this.useFontFamily=true,
    this.fontWeight,
});

  @override
  Widget build(BuildContext context) => OutlinedText(
    text: Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: null==withOpacity?color.toColor():color.toColor().withOpacity(withOpacity!),
        fontFamily: useFontFamily==true?"baloo":null,
        decoration: decoration,
        fontWeight: fontWeight,
        decorationColor: null==withOpacity?decorationColor?.toColor():decorationColor?.toColor().withOpacity(withOpacity!),
      ),
    ),
    strokes: null==outLineColor?
    []:
    [
      OutlinedTextStroke(
        color: outLineColor!.toColor(),
        width: 2.w,
      ),
    ],
  );
}