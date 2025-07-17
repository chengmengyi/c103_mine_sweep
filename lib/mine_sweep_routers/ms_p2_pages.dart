import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/cash_child/input_account/input_account_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/ms_p2_home_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play10/ms_p2_play10_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play20/ms_p2_play20_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play30/ms_p2_play30_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play40/ms_p2_play40_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play50/ms_p2_play50_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play60/ms_p2_play60_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play70/ms_p2_play70_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play80/ms_p2_play80_page.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:get/get.dart';

class MsP2Pages{
  static List<GetPage> list=[
    GetPage(
      name: MsP2RoutersName.home,
      page: ()=> MsP2HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play10,
      page: ()=> MsP2Play10Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play20,
      page: ()=> MsP2Play20Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play30,
      page: ()=> MsP2Play30Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play40,
      page: ()=> MsP2Play40Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play50,
      page: ()=> MsP2Play50Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play60,
      page: ()=> MsP2Play60Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play70,
      page: ()=> MsP2Play70Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.play80,
      page: ()=> MsP2Play80Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP2RoutersName.inputAccount,
      page: ()=> InputAccountPage(),
      transition: Transition.fadeIn,
    ),
  ];
}