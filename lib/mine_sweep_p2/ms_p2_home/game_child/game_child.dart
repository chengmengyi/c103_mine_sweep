import 'package:c103_mine_sweep/mine_sweep_base/ms_base_child.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/game_child/game_child_con.dart';
import 'package:flutter/material.dart';

class GameChild extends MsBaseChild<GameChildCon>{

  @override
  GameChildCon initMsCon() => GameChildCon();

  @override
  Widget buildMsWidget() => Stack();
}