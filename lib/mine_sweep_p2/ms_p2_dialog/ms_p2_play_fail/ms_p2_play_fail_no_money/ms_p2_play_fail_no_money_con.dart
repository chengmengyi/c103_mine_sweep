import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

class MsP2PlayFailNoMoneyCon extends MsBaseCon{

  clickReplay(Function() clickReplay){
    MsRouterUtils.instance.back();
    clickReplay.call();
  }

  clickHome(Function() clickHome){
    MsRouterUtils.instance.back();
    clickHome.call();
  }
}