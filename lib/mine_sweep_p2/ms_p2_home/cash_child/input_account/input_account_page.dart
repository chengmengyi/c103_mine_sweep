import 'package:c103_mine_sweep/mine_sweep_base/ms_base_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/cash_child/input_account/input_account_controller.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter/material.dart';

class InputAccountPage extends MsBasePage<InputAccountController>{

  @override
  InputAccountController initMsCon() => InputAccountController();

  @override
  Widget buildMsWidget() => Container(
    width: double.infinity,
    height: double.infinity,
    color: "#FFF9E8".toColor(),
    child: Stack(
      children: [

      ],
    ),
  );
}