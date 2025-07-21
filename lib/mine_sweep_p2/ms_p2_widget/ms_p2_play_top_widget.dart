import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_diamond/ms_p2_diamond_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_set/ms_p2_set_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MsP2PlayTopWidget extends MsBaseStateful{
  Function()? clickHome;
  Function()? clickResume;
  GlobalKey? topMoneyGlobalKey;
  MsP2PlayTopWidget({
    this.clickHome,
    this.clickResume,
    this.topMoneyGlobalKey,
  });

  @override
  State<StatefulWidget> createState() => MsP2PlayTopWidgetState();
}

class MsP2PlayTopWidgetState extends MsBaseStatefulState<MsP2PlayTopWidget> with SingleTickerProviderStateMixin {
  late AnimationController _boxController;
  late Animation<double> _boxScaleAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimator();
    _updateDiamond();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: MediaQuery.of(context).padding.top+104.h,
    child: Stack(
      children: [
        MsImages(imagesName: "play_top1",width: double.infinity,height: double.infinity,),
        _boxWidget(),
        _progressWidget(),
        _setWidget(),
        _backWidget(),
      ],
    ),
  );

  _backWidget()=>Positioned(
    left: 9.w,
    bottom: 41.h,
    child: MsClick(
      onTap: (){
        MsRouterUtils.instance.back();
      },
      child: MsImages(imagesName: "icon_close3",width: 36.w,height: 36.w,),
    ),
  );

  _boxWidget()=>Positioned(
    left: 36.w,
    bottom: 0,
    child: MsClick(
      onTap: (){
        _showDiamondDialog();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          MsImages(imagesName: "home3",width: 104.w,height: 104.h,),
          ScaleTransition(
            scale: _boxScaleAnimation,
            child: MsImages(imagesName: "home4",width: 70.w,height: 56.h,),
          ),
        ],
      ),
    ),
  );

  _progressWidget()=> Positioned(
    left: 130.w,
    bottom: 46.h,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _coinsWidget(),
        SizedBox(width: 4.w,),
        _diamondWidget(),
        SizedBox(width: 40.w,),
      ],
    ),
  );

  _setWidget()=>Positioned(
    right: 18.w,
    bottom: 26.h,
    child: MsClick(
      onTap: (){
        MsRouterUtils.instance.showDialog(
          child: MsP2SetDialog(
            fromHome: false,
            clickHome: widget.clickHome,
            clickResume: widget.clickResume,
          ),
        );
      },
      child: MsImages(imagesName: "icon_set",width: 32.w,height: 32.h,),
    ),
  );

  _coinsWidget()=>MsClick(
    onTap: (){
      _clickCoins();
    },
    child: SizedBox(
      width: 108.w,
      height: 24.h,
      key: widget.topMoneyGlobalKey,
      child: Stack(
        children: [
          MsImages(imagesName: "home6",width: 108.w,height: 24.h,),
          Align(
            alignment: Alignment.centerRight,
            child: MsImages(imagesName: "icon_money",width: 38.w,boxFit: BoxFit.fitWidth,),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 108.w,
              height: 24.h,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 20.w,top: 3.h),
              child: MsText(text: "${p2CoinsNum.getData()}", size: 17.sp, color: "#FFFFFF",outLineColor: "#3F0000",),
            ),
          )
        ],
      ),
    ),
  );

  _diamondWidget()=>SizedBox(
    width: 74.w,
    height: 24.h,
    child: Stack(
      children: [
        MsImages(imagesName: "home6",width: 108.w,height: 24.h,),
        Align(
          alignment: Alignment.centerRight,
          child: MsImages(imagesName: "icon_diamond",width: 24.w,height: 24.h,),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 108.w,
            height: 24.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 20.w,top: 3.h),
            child: MsText(text: "${p2DiamondNum.getData()}", size: 17.sp, color: "#FFFFFF",outLineColor: "#3F0000",),
          ),
        )
      ],
    ),
  );

  _levelWidget()=>MsText(
    text: "level ${P2UserInfoUtils.instance.getCurrentLevelNum()}",
    size: 20.sp,
    color: "#FFFCEB",
    outLineColor: "#570000",
  );

  _showDiamondDialog(){
    MsRouterUtils.instance.showDialog(child: MsP1DiamondDialog());
  }

  _initAnimator(){
    _boxController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _boxScaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _boxController, curve: Curves.easeInOut),
    );
  }

  _clickCoins(){
    MsRouterUtils.instance.back();
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.showHomeIndex,intValue: 1);
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.updateCoins:
      case MsP2EventCode.updateLevel:
        setState(() {});
      break;
      case MsP2EventCode.updateDiamond:
        setState(() {});
        _updateDiamond();
        break;
    }
  }

  _updateDiamond(){
    var list = MsP2ValueUtils.instance.getDiamondList();
    if(list.isEmpty){
      return;
    }
    if(p2DiamondNum.getData()>=(list.first.num??0)){
      _boxController.repeat(reverse: true);
    }else{
      _boxController.stop();
    }
  }

  @override
  void dispose() {
    _boxController.dispose();
    super.dispose();
  }
}