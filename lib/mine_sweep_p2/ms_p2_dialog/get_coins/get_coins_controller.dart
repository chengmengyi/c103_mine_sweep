import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';

class GetCoinsController extends MsBaseCon{

  clickDouble(double addNum,Function() success){
    MsAdUtils.instance.showP2222Ad(
      adType: AdType.reward,
      close: (){
        P2UserInfoUtils.instance.updateCoinsNum(valuex2(addNum));
        MsRouterUtils.instance.back();
        success.call();
      },
    );
  }

  clickSingle(double addNum,Function() success){
    MsAdUtils.instance.showP2222Ad(
      adType: AdType.interstitial,
      close: (){
        P2UserInfoUtils.instance.updateCoinsNum(addNum);
        MsRouterUtils.instance.back();
        success.call();
      },
    );
  }
}