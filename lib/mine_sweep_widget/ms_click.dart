import 'package:flutter/material.dart';

class MsClick extends StatelessWidget{
  Widget? child;
  Function()? onTap;
  MsClick({this.child,this.onTap,});

  @override
  Widget build(BuildContext context) => InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: (){
      onTap?.call();
    },
    child: child??Container(),
  );
}