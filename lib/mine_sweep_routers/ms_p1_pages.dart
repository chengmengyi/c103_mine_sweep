import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_home/ms_p1_home_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_play10/ms_p1_play10_page.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_play20/ms_p1_play20_page.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:get/get.dart';

class MsP1Pages{
  static List<GetPage> list=[
    GetPage(
      name: MsP1RoutersName.home,
      page: ()=> MsP1HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP1RoutersName.play10,
      page: ()=> MsP1Play10Page(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsP1RoutersName.play20,
      page: ()=> MsP1Play20Page(),
      transition: Transition.fadeIn,
    ),
  ];
}