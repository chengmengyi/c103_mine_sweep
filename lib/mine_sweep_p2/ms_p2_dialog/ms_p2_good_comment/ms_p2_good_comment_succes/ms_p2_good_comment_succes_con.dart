import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

class MsP2GoodCommentSuccesCon extends MsBaseCon{
  clickClose(){
    P2UserInfoUtils.instance.updateCoinsNum(5);
    MsRouterUtils.instance.back();
  }
}