import 'dart:math';

import 'package:c103_mine_sweep/mine_sweep_base/ms_base_statefull.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_tomado/ms_p1_tornado_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_dialog/ms_p1_wild/ms_p1_wild_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_play_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/p1_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_click.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MsP1BottomWidget extends MsBaseStateful{
  MsP1PlayUtils p1playUtils;
  MsP1BottomWidget({required this.p1playUtils});

  @override
  State<StatefulWidget> createState() => MsP1BottomWidgetState();
}

class MsP1BottomWidgetState extends MsBaseStatefulState<MsP1BottomWidget> with TickerProviderStateMixin{
  var showHandCardAnimator=false,pointCardShowFront=false;
  Animation<Offset>? _handCardAnimation;
  late AnimationController _handCardController;
  late AnimationController _pointCardController;
  GlobalKey handCardGlobalKey=GlobalKey();
  GlobalKey pointCardGlobalKey=GlobalKey();

  @override
  void initState() {
    super.initState();
    _initHandCardAnimator();
    _initPointCardAnimator();
    Future((){
      widget.p1playUtils.iniPointCardGlobalKey(pointCardGlobalKey);
    });
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: SizedBox(
      width: double.infinity,
      height: 79.h,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(width: 16.w,),
              _handsCardWidget(),
              _pointCardWidget(),
              _wannengWidget(),
              SizedBox(width: 10.w,),
              _longjuanfengWidget(),
              SizedBox(width: 16.w,),
            ],
          ),
          _handsCardAnimatorWidget(),
        ],
      ),
    ),
  );

  _pointCardWidget()=>Expanded(
    child: Center(
      child: Visibility(
        visible: !showHandCardAnimator,
        child: AnimatedBuilder(
          key: pointCardGlobalKey,
          animation: _pointCardController,
          builder: (context, child) {
            double angle = _pointCardController.value * pi;
            bool isBack = angle > pi / 2;
            return Transform(
              transform: _getTransform(angle),
              alignment: Alignment.center,
              child: isBack ? _backgroundWidget(): _frontCardWidget(),
            );
          },
        ),
      ),
    ),
  );

  _getTransform(angle)=>Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(angle);

  _getRotationY()=>Matrix4.rotationY(pi);

  _backgroundWidget()=>Transform(
    alignment: Alignment.center,
    transform: _getRotationY(),
    child: MsImages(imagesName: "card_background",width: 53.w,height: 79.h,),
  );

  _frontCardWidget(){
    if(widget.p1playUtils.hasWildCard){
      return MsImages(
        imagesName: "card_wild",
        width: 53.w,
        height: 79.h,
      );
    }
    var bean = widget.p1playUtils.p1pointBean;
    return MsImages(
      imagesName: getCardIcon(cardText: bean?.cardText, cardTypeEnum: bean?.cardTypeEnum),
      width: 53.w,
      height: 79.h,
    );
  }

  _wannengWidget()=>MsClick(
    onTap: (){
      _showWildDialog();
    },
    child: MsImages(imagesName: "bottom1",width: 59.w,height: 63.h,),
  );
  
  _longjuanfengWidget()=>MsClick(
    onTap: (){
      _showTornadoDialog();
    },
    child: MsImages(imagesName: "bottom2",width: 59.w,height: 65.h,),
  );

  _handsCardWidget()=>MsClick(
    onTap: (){
      _clickHandCard();
    },
    child: SizedBox(
      width: 85.w,
      key: handCardGlobalKey,
      child: Stack(
        children: List.generate(widget.p1playUtils.currentHandsNum, (index){
          return Container(
            margin: EdgeInsets.only(left: index<=4?index*8.w: 32.w),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _handsCardItemWidget(),
                Visibility(
                  visible: index==widget.p1playUtils.currentHandsNum-1,
                  child: Container(
                    width: 42.w,
                    height: 14.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: "#000000".toColor().withOpacity(0.7),
                    ),
                    child: MsText(text: "${widget.p1playUtils.currentHandsNum}", size: 14.sp, color: "#FFFFFF"),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    ),
  );
  
  _handsCardItemWidget()=>MsImages(imagesName: "card_background",width: 53.w,height: 79.h,);

  _handsCardAnimatorWidget(){
    if(!showHandCardAnimator){
      return Container();
    }

    var value = _handCardAnimation?.value;
    var dx = value?.dx??0;
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: dx<=0?0:dx),
          child: MsImages(imagesName: "card_background",width: 53.w,height: 79.h,),
        )
      ],
    );
  }

  _clickHandCard(){
    if(widget.p1playUtils.currentHandsNum<=0||_handCardAnimation?.isAnimating==true||!widget.p1playUtils.canClick){
      return;
    }
    widget.p1playUtils.canClick=false;
    var handCardRenderBox = handCardGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var handCardOffset = handCardRenderBox.localToGlobal(Offset.zero);
    var currentHandsNum = widget.p1playUtils.currentHandsNum;
    handCardOffset=Offset(handCardOffset.dx+((8.w)*(currentHandsNum>5?5:currentHandsNum-1)), handCardOffset.dy);
    var pointRenderBox = pointCardGlobalKey.currentContext!.findRenderObject() as RenderBox;
    var pointOffset = pointRenderBox.localToGlobal(Offset.zero);
    widget.p1playUtils.canClick=false;
    showHandCardAnimator=true;
    pointCardShowFront=false;
    _pointCardController.value=1.0;
    widget.p1playUtils.updateHandsNum(-1);
    setState(() {});

    _handCardAnimation=Tween<Offset>(
      begin: handCardOffset,
      end: pointOffset,
    ).animate(CurvedAnimation(parent: _handCardController, curve: Curves.easeInOut));
    _handCardController..reset()..forward();
  }


  _initHandsCard()async{
    if(pageClosed){
      return;
    }
    if(widget.p1playUtils.currentHandsNum>=17){
      widget.p1playUtils.canClick=true;
      return;
    }
    while(widget.p1playUtils.currentHandsNum<17){
      if(pageClosed){
        return;
      }
      widget.p1playUtils.updateHandsNum(1);
      setState(() {});
      await Future.delayed(Duration(milliseconds: 200));
    }
  }

  _initHandCardAnimator(){
    _handCardController=AnimationController(vsync: this,duration: const Duration(milliseconds: 300))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if(status==AnimationStatus.completed){
          setState(() {
            showHandCardAnimator=false;
          });
          widget.p1playUtils.setBottomCenterCard(reset: true);
        }
      });
  }

  _initPointCardAnimator(){
    _pointCardController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
      value: 1.0,
    )..addStatusListener((status){
      if(status==AnimationStatus.dismissed||status==AnimationStatus.completed){
        widget.p1playUtils.canClick=true;
      }
    });
  }

  _showWildDialog(){
    if(!widget.p1playUtils.canClick){
      return;
    }
    MsRouterUtils.instance.showDialog(
      child: MsP1WildDialog(
        getWildCallback: (){
          setState(() {
            widget.p1playUtils.hasWildCard=true;
          });
        },
      ),
    );
  }

  _showTornadoDialog(){
    if(!widget.p1playUtils.canClick){
      return;
    }
    MsRouterUtils.instance.showDialog(
      child: MsP1TornadoDialog(
        getWildCallback: (){
          var result = widget.p1playUtils.cardList.expand((row) => row).where((card) => card.canShow&&!card.isCoveredCard).toList();
          MsEventUtils.instance.sendMsg(code: MsP1EventCode.startTornadoAnimator,anyValue: result);
        },
      ),
    );
  }


  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP1EventCode.pointCardTurnOver:
        _startTurnOverPointCard();
        break;
      case MsP1EventCode.refreshPointCard:
        setState(() {});
        break;
      case MsP1EventCode.addHandCardsNum:
        setState(() {});
        break;
      case MsP1EventCode.resetBottomInfo:
        setState(() {
          pointCardShowFront=false;
          showHandCardAnimator=false;
          _pointCardController.value=1.0;
        });
        _initHandsCard();
        break;
      case MsP1EventCode.handleHandsCard:
        _handleHandsCard();
        break;
      case MsP1EventCode.startInitHandsCard:
        _initHandsCard();
        break;
    }
  }

  _handleHandsCard()async{
    if(widget.p1playUtils.currentHandsNum<=0){
      return;
    }
    P1UserInfoUtils.instance.updateCoinsNum(100);
    setState(() {
      widget.p1playUtils.updateHandsNum(-1);
    });
    MsVoiceUtils.instance.playMusic(MusicType.xiaochu);
    await Future.delayed(const Duration(milliseconds: 400));
    _handleHandsCard();
  }

  _startTurnOverPointCard(){
    setState(() {});
    if (pointCardShowFront) {
      _pointCardController.forward();
    } else {
      _pointCardController.reverse();
    }
    pointCardShowFront = !pointCardShowFront;
  }

  @override
  void dispose() {
    _handCardController.dispose();
    _pointCardController.dispose();
    super.dispose();
  }
}