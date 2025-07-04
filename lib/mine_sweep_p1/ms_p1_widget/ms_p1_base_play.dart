import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_play_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_get_coins_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_get_tomado_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_p1_card_move_animator_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_p1_tornado_animator_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_p1_bottom_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_widget/ms_p1_top_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_spine_widget.dart';
import 'package:flutter/material.dart';

class MsP1BasePlay extends StatelessWidget{
  MsP1PlayUtils p1playUtils;
  Widget child;
  Function()? clickHome;
  Function()? clickResume;

  MsP1BasePlay({
    required this.p1playUtils,
    required this.child,
    this.clickHome,
    this.clickResume,
  });
  @override
  Widget build(BuildContext context) => Stack(
    children: [
      MsImages(imagesName: "play_bg",width: double.infinity,height: double.infinity,),
      Column(
        children: [
          MsP1TopWidget(clickHome: clickHome,clickResume: clickResume,),
          Expanded(
            child: Center(
              child: child,
            ),
          ),
          MsP1BottomWidget(p1playUtils: p1playUtils,),
        ],
      ),
      MsP1CardMoveAnimatorWidget(),
      MsP1TornadoAnimatorWidget(),
      MsGetCoinsLottieWidget(),
      MsGetTomadoLottieWidget(),
    ],
  );
}