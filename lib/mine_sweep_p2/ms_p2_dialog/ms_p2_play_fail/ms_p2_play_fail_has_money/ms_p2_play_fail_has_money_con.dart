import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

class MsP2PlayFailHasMoneyCon extends MsBaseCon{

  clickGetCards(Function() clickGetCards){
    P2UserInfoUtils.instance.updateCoinsNum(-2000);
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