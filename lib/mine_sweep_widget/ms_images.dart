import 'package:flutter/material.dart';

class MsImages extends StatelessWidget{
  String imagesName;
  double? width;
  double? height;
  BoxFit? boxFit;

  MsImages({
    required this.imagesName,
    this.width,
    this.height,
    this.boxFit,
});

  @override
  Widget build(BuildContext context) => Image.asset(
    "assets/images/$imagesName.webp",
    width: width,
    height: height,
    fit: boxFit??BoxFit.fill,
  );
}