import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_play_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_get_coins_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_get_tomado_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_card_move_animator_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_tornado_animator_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_images.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_bottom_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_widget/ms_p2_top_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_lottie_widget.dart';
import 'package:c103_mine_sweep/mine_sweep_widget/ms_spine_widget.dart';
import 'package:flutter/material.dart';

class MsP2BasePlay extends StatelessWidget{
  MsP2PlayUtils p1playUtils;
  Widget child;
  Function()? clickHome;
  Function()? clickResume;

  MsP2BasePlay({
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
          MsP2TopWidget(clickHome: clickHome,clickResume: clickResume,),
          Expanded(
            child: Center(
              child: child,
            ),
          ),
          MsP2BottomWidget(p1playUtils: p1playUtils,),
        ],
      ),
      MsP2CardMoveAnimatorWidget(),
      MsP2TornadoAnimatorWidget(),
      MsGetCoinsLottieWidget(),
      MsGetTomadoLottieWidget(),
    ],
  );
}