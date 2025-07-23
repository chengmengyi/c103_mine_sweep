import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2ReachCashCon extends MsBaseCon{
  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.withdraw_reach_pop);
  }

  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickBtn(){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.withdraw_reach_c);
    MsRouterUtils.instance.back();
    MsRouterUtils.instance.toNamed(routersName: MsP2RoutersName.inputAccount,arguments: {"cashTypeIndex":0,"cashAmount":MsP2ValueUtils.instance.getCashList().first,},);
  }
}