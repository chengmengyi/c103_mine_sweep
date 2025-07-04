import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';

class MsGraText extends StatelessWidget{
  String text;
  double size;
  List<Color> colors;
  FontWeight? fontWeight;
  AlignmentGeometry? begin;
  AlignmentGeometry? end;
  String? outLineColor;
  TextAlign? textAlign;
  TextOverflow? overflow;

  MsGraText({
    required this.text,
    required this.size,
    required this.colors,
    this.fontWeight,
    this.begin,
    this.end,
    this.outLineColor,
    this.textAlign,
    this.overflow,
  });


  @override
  Widget build(BuildContext context) => ShaderMask(
    shaderCallback: (rect) {
      return LinearGradient(
        begin: begin??Alignment.topCenter,
        end: end??Alignment.bottomCenter,
        colors: colors,
      ).createShader(rect);
    },
    child: MsText(
      text: text,
      size: size,
      color: "#FFFFFF",
      outLineColor: outLineColor,
    ),
  );
}