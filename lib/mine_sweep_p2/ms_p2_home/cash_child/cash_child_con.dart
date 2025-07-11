import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';

class CashChildCon extends MsBaseCon{
  var cashTypeIndex=0;

  clickCashType(index){
    if(cashTypeIndex==index){
      return;
    }
    cashTypeIndex=index;
    update(["page"]);
  }

  clickCash(){
    MsRouterUtils.instance.toNamed(routersName: MsP2RoutersName.inputAccount);
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.updateCoins:
        update(["coins"]);
        break;
    }
  }
}