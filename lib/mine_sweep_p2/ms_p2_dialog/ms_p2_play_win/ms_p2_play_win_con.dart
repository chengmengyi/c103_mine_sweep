import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

class MsP2PlayWinCon extends MsBaseCon{

  clickNext(Function() clickNext){
    MsRouterUtils.instance.back();
    clickNext.call();
  }

  clickHome(Function() clickHome){
    MsRouterUtils.instance.back();
    clickHome.call();
  }
}