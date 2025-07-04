import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MsBaseDialog<C extends MsBaseCon> extends StatelessWidget{
  bool _initView=true;
  late C msCon;

  @override
  Widget build(BuildContext context) {
    _initVVVV(context);
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: buildMsWidget(),
      ),
    );
  }

  init(){}

  Widget buildMsWidget();

  C initMsCon();

  _initVVVV(BuildContext context){
    if(_initView){
      msCon=Get.put(initMsCon());
      msCon.context=context;
      init();
    }
    _initView=false;
  }
}