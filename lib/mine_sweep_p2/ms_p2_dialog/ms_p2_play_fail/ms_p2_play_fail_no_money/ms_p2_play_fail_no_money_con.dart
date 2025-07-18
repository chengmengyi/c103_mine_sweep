import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

import '../../../../mine_sweep_storage/p2/p2_storage.dart';
import '../../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2PlayFailNoMoneyCon extends MsBaseCon{
  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.game_page_fail,params: {"level":p2LevelNum.getData()});
  }

  clickReplay(Function() clickReplay){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.fail_replay_c,params: {"level":p2LevelNum.getData()});
    MsRouterUtils.instance.back();
    clickReplay.call();
  }

  clickHome(Function() clickHome){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.fail_home_c,params: {"level":p2LevelNum.getData()});
    MsRouterUtils.instance.back();
    clickHome.call();
  }
}