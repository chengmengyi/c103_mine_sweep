import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_swwep_common_page/mine_sweep_launch/ms_launch_page.dart';
import 'package:c103_mine_sweep/mine_swwep_common_page/mine_swwep_web/ms_web_page.dart';
import 'package:get/get.dart';

class MsCommonPages{
  static List<GetPage> list=[
    GetPage(
      name: MsCommonRoutersName.launch,
      page: ()=> MsLaunchPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: MsCommonRoutersName.web,
      page: ()=> MsWebPage(),
      transition: Transition.fadeIn,
    ),
  ];
}