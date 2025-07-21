import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_no_network/ms_p2_no_network_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_network_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';

import '../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class GetCoinsController extends MsBaseCon{

  clickClose(GetCoinsFrom getCoinsFrom,Function() success){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.claim_pop_close,params: {"pop_scene":getCoinsFrom.name});
    MsRouterUtils.instance.back();
    success.call();
  }

  clickDouble(GetCoinsFrom getCoinsFrom,double addNum,Function() success, bool fromDiamond)async{
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.claim_pop_claim,params: {"pop_scene":getCoinsFrom.name});
    if(!(await _checkHasNetwork(getCoinsFrom))){
      return;
    }
    MsAdUtils.instance.showP2222Ad(
      adType: AdType.reward,
      close: (){
        if(fromDiamond){
          P2UserInfoUtils.instance.updateDiamond(addNum.toInt()*2);
        }else{
          P2UserInfoUtils.instance.updateCoinsNum(valuex2(addNum));
        }
        MsRouterUtils.instance.back();
        success.call();
      },
    );
  }

  clickSingle(GetCoinsFrom getCoinsFrom,double addNum,Function() success, bool fromDiamond)async{
    if(!(await _checkHasNetwork(getCoinsFrom))){
      return;
    }
    MsAdUtils.instance.showP2222Ad(
      adType: AdType.interstitial,
      close: (){
        if(fromDiamond){
          P2UserInfoUtils.instance.updateDiamond(addNum.toInt());
        }else{
          P2UserInfoUtils.instance.updateCoinsNum(addNum);
        }
        MsRouterUtils.instance.back();
        success.call();
      },
    );
  }

  Future<bool> _checkHasNetwork(GetCoinsFrom getCoinsFrom)async{
    var result = await MsP2NetworkUtils.instance.checkHasNetwork();
    if(!result){
      MsRouterUtils.instance.showDialog(child: MsP2NoNetworkDialog(getCoinsFrom: getCoinsFrom,));
    }
    return result;
  }
}