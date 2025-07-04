import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_diamond/ms_p1_diamond_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_set/ms_p1_set_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/p1_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MsP1TopWidget extends MsBaseStateful{
  bool showLevel;
  Function()? clickHome;
  Function()? clickResume;
  MsP1TopWidget({
    this.showLevel=true,
    this.clickHome,
    this.clickResume,
  });

  @override
  State<StatefulWidget> createState() => MsP1TopWidgetState();
}

class MsP1TopWidgetState extends MsBaseStatefulState<MsP1TopWidget> with SingleTickerProviderStateMixin {
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
        MsImages(imagesName: "home2",width: double.infinity,height: double.infinity,),
        _boxWidget(),
        _progressWidget(),
        _setWidget(),
      ],
    ),
  );

  _boxWidget()=>Positioned(
    left: 0,
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

  _progressWidget()=>SafeArea(
    top: true,
    child: Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(left: 100.w,right: 14.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.showLevel?
            _levelWidget():
            MsImages(imagesName: "home11",height: 21.h,boxFit: BoxFit.fitHeight,),
            SizedBox(height: 4.h,),
            Row(
              children: [
                _diamondWidget(),
                SizedBox(width: 4.w,),
                _coinsWidget(),
                SizedBox(width: 40.w,),
              ],
            )
          ],
        ),
      ),
    ),
  );

  _setWidget()=>Positioned(
    right: 18.w,
    bottom: 26.h,
    child: MsClick(
      onTap: (){
        MsRouterUtils.instance.showDialog(
          child: MsP1SetDialog(
            fromHome: !widget.showLevel,
            clickHome: widget.clickHome,
            clickResume: widget.clickResume,
          ),
        );
      },
      child: MsImages(imagesName: "icon_set",width: 32.w,height: 32.h,),
    ),
  );

  _coinsWidget()=>SizedBox(
    width: 108.w,
    height: 24.h,
    child: Stack(
      children: [
        MsImages(imagesName: "home6",width: 108.w,height: 24.h,),
        Align(
          alignment: Alignment.centerRight,
          child: MsImages(imagesName: "icon_coins",width: 24.w,height: 24.h,),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 108.w,
            height: 24.h,
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 20.w,top: 3.h),
            child: MsText(text: "${p1CoinsNum.getData()}", size: 17.sp, color: "#FFFFFF",outLineColor: "#3F0000",),
          ),
        )
      ],
    ),
  );

  _diamondWidget()=>SizedBox(
    width: 108.w,
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
            child: MsText(text: "${p1DiamondNum.getData()}", size: 17.sp, color: "#FFFFFF",outLineColor: "#3F0000",),
          ),
        )
      ],
    ),
  );

  _levelWidget()=>MsText(
    text: "level ${P1UserInfoUtils.instance.getCurrentLevelNum()}",
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

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP1EventCode.updateCoins:
      case MsP1EventCode.updateLevel:
        setState(() {});
      break;
      case MsP1EventCode.updateDiamond:
        setState(() {});
        _updateDiamond();
        break;
    }
  }

  _updateDiamond(){
    if(p1DiamondNum.getData()>=9){
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