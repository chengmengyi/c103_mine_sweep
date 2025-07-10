import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_home/ms_p2_home_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play10/ms_p2_play10_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_play20/ms_p2_play20_page.dart';
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
  ];
}