import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_card_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/step1_guide_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/step2_guide_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/step4_guide_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/step5_guide_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/step7_guide_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/step8_guide_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:flutter/material.dart';

class MsP2GuideUtils {
  static final MsP2GuideUtils _utils=MsP2GuideUtils();
  static MsP2GuideUtils get instance => _utils;

  OverlayEntry? _overlayEntry;
  var _currentGuideStep=1;

  showStep1Guide(BuildContext context,GlobalKey btnGlobalKey){
    if(!p2ShowGuideUser.getData()||_currentGuideStep!=1){
      return;
    }
    var renderBox = btnGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step1GuideWidget(
        offset: offset,
        dismissCallback: (){
          _currentGuideStep=2;
          MsRouterUtils.instance.toNamed(routersName: MsP2RoutersName.play10);
        },
      ),
    );
  }

  showStep2Guide({
    required BuildContext context,
    required List<List<MsP2CardBean>> cardList,
    required Function(MsP2CardBean bean) dismissCallback,
  }){
    if(!p2ShowGuideUser.getData()||_currentGuideStep!=2){
      return;
    }
    MsP2CardBean? p2cardBean = cardList.expand((row) => row).where((c) => !c.isCoveredCard && c.canShow && c.cardText.isNotEmpty && c.isMoneyCard).cast<MsP2CardBean?>().firstOrNull;
    if(null!=p2cardBean){
      var renderBox = p2cardBean.globalKey.currentContext!.findRenderObject() as RenderBox;
      var offset = renderBox.localToGlobal(Offset.zero);
      showOverlay(
        context: context,
        widget: Step2GuideWidget(
          offset: offset,
          dismissCallback: (){
            _currentGuideStep=4;
            dismissCallback.call(p2cardBean);
          },
        ),
      );
    }
  }

  showStep4Guide(BuildContext context, GlobalKey topMoneyGlobalKey){
    if(!p2ShowGuideUser.getData()||_currentGuideStep!=4){
      return;
    }
    var renderBox = topMoneyGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step4GuideWidget(
        offset: offset,
        dismissCallback: (){
          _currentGuideStep=5;
          MsRouterUtils.instance.offAllUnit(routersName: MsP2RoutersName.home);
          MsEventUtils.instance.sendMsg(code: MsP2EventCode.showHomeIndex,intValue: 1);
          MsEventUtils.instance.sendMsg(code: MsP2EventCode.showCashGuide);
        },
      ),
    );
  }

  showStep5Guide({
    required BuildContext context,
    required GlobalKey amountGlobalKey,
    required Function() dismissCallback,
  }){
    if(!p2ShowGuideUser.getData()||_currentGuideStep!=5){
      return;
    }
    var renderBox = amountGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step5GuideWidget(
        offset: offset,
        dismissCallback: (){
          _currentGuideStep=6;
          dismissCallback.call();
        },
      ),
    );
  }

  showStep7Guide({
    required BuildContext context,
    required GlobalKey tomadoGlobalKey,
    required Function() dismissCallback,
  }){
    var renderBox = tomadoGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step7GuideWidget(
        offset: offset,
        dismissCallback: (){
          dismissCallback.call();
        },
      ),
    );
  }


  showStep8Guide({
    required BuildContext context,
    required GlobalKey wildGlobalKey,
    required Function() dismissCallback,
  }){
    var renderBox = wildGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var offset = renderBox.localToGlobal(Offset.zero);
    showOverlay(
      context: context,
      widget: Step8GuideWidget(
        offset: offset,
        dismissCallback: (){
          dismissCallback.call();
        },
      ),
    );
  }


  showOverlay({
    required BuildContext context,
    required Widget widget,
  }){
    _overlayEntry=OverlayEntry(builder: (_)=>widget);
    Overlay.of(context).insert(_overlayEntry!);
  }

  hideOverlay(){
    _overlayEntry?.remove();
    _overlayEntry=null;
  }
}