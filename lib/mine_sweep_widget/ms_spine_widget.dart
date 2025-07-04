import 'package:flutter/material.dart';
import 'package:spine_flutter/spine_flutter.dart';

class MsSpineWidget extends StatelessWidget{
  String atlasFile;
  String skeletonFile;
  String animatorName;
  double? width;
  double? height;
  BoxFit? fit;
  MsSpineWidget({
    required this.atlasFile,
    required this.skeletonFile,
    required this.animatorName,
    this.width,
    this.height,
    this.fit,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: 200,
    height: 200,
    child: SpineWidget.fromAsset(
      "assets/lottie/$atlasFile.atlas",
      "assets/lottie/$skeletonFile.json",
      SpineWidgetController(
        onInitialized: (controller) {
          print("Spine 控件初始化完成");
          controller.animationState.setAnimationByName(0, animatorName, true);
        },
      ),
      fit: fit??BoxFit.fill,
    ),
  );
}