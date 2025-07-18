import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

import '../../../mine_sweep_storage/p2/p2_storage.dart';
import '../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2CardGameCon extends MsBaseCon{
  var cakClick=true;
  var addNum=MsP2ValueUtils.instance.getCardGamesReward();

  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.card_view,params: {"level":p2LevelNum.getData()});
  }

  clickClose(Function(double addNum) dismissDialog){
    if(!cakClick){
      return;
    }
    MsRouterUtils.instance.back();
    dismissDialog.call(0);
  }

  clickCardCallback(Function(double addNum) dismissDialog)async{
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.card_click,params: {"level":p2LevelNum.getData()});
    cakClick=false;
    await Future.delayed(Duration(milliseconds: 3000));
    MsRouterUtils.instance.back();
    dismissDialog.call(addNum);
  }
}