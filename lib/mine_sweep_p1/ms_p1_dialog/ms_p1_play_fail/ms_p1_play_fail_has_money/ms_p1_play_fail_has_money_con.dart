import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/p1_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

class MsP1PlayFailHasMoneyCon extends MsBaseCon{

  clickGetCards(Function() clickGetCards){
    P1UserInfoUtils.instance.updateCoinsNum(-2000);
    MsRouterUtils.instance.back();
    clickGetCards.call();
  }

  clickReplay(Function() clickReplay){
    MsRouterUtils.instance.back();
    clickReplay.call();
  }

  clickHome(Function() clickHome){
    MsRouterUtils.instance.back();
    clickHome.call();
  }
}