import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MsLottieWidget extends StatelessWidget{
  String lottieName;
  double? width;
  double? height;
  BoxFit? fit;
  String? ext;
  bool? repeat;
  AnimationController? animationController;
  MsLottieWidget({
    required this.lottieName,
    this.width,
    this.height,
    this.fit,
    this.ext,
    this.repeat,
    this.animationController,
});

  @override
  Widget build(BuildContext context) => Lottie.asset(
    "assets/lottie/$lottieName.${ext??"json"}",
    width: width,
    height: height,
    repeat: repeat,
    fit: fit??BoxFit.fill,
    controller: animationController,
  );
}