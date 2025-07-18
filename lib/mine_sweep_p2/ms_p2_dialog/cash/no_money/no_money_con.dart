import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class NoMoneyCon extends MsBaseCon{

  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.cash_not_enough_pop);
  }

  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickBtn(){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.cash_not_enough_c);
    MsRouterUtils.instance.back();
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.showHomeIndex,intValue: 0);
  }

}