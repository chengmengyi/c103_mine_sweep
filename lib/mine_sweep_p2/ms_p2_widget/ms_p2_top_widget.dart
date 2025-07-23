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
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MsP2TopWidget extends MsBaseStateful{
  bool showLevel;
  GlobalKey topCoinsGlobalKey;
  Function()? clickHome;
  Function()? clickResume;
  MsP2TopWidget({
    required this.topCoinsGlobalKey,
    this.showLevel=true,
    this.clickHome,
    this.clickResume,
  });

  @override
  State<StatefulWidget> createState() => MsP2TopWidgetState();
}

class MsP2TopWidgetState extends MsBaseStatefulState<MsP2TopWidget> with SingleTickerProviderStateMixin {
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
                _coinsWidget(),
                SizedBox(width: 4.w,),
                _diamondWidget(),
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
        MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.home_page_setting);
        MsRouterUtils.instance.showDialog(
          child: MsP2SetDialog(
            fromHome: !widget.showLevel,
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
      key: widget.topCoinsGlobalKey,
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