import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MsLottieWidget extends StatelessWidget{
  String lottieName;
  double? width;
  double? height;
  BoxFit? fit;
  MsLottieWidget({
    required this.lottieName,
    this.width,
    this.height,
    this.fit,
});

  @override
  Widget build(BuildContext context) => Lottie.asset(
    "assets/lottie/$lottieName.json",
    width: width,
    height: height,
    fit: fit??BoxFit.fill,
  );
}