import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_pos_id.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';

import '../../../mine_sweep_storage/p2/p2_storage.dart';
import '../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2PlayFailCon extends MsBaseCon{
  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.game_page_fail,params: {"level":p2LevelNum.getData()});
  }

  clickGetCards(Function() clickGetCards){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.fail_getcards_c,params: {"level":p2LevelNum.getData()});
    MsRouterUtils.instance.back();
    clickGetCards.call();
  }

  clickReplay(Function() clickReplay){
    MsAdUtils.instance.showP2222Ad(
      adType: AdType.interstitial,
      msAdPosId: MsAdPosId.ohqxn_victorypop_int,
      close: (){
        MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.fail_replay_c,params: {"level":p2LevelNum.getData()});
        MsRouterUtils.instance.back();
        clickReplay.call();
      },
    );
  }

  clickHome(Function() clickHome){
    MsAdUtils.instance.showP2222Ad(
      adType: AdType.interstitial,
      msAdPosId: MsAdPosId.ohqxn_victorypop_int,
      close: (){
        MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.fail_home_c,params: {"level":p2LevelNum.getData()});
        MsRouterUtils.instance.back();
        clickHome.call();
      },
    );
  }
}