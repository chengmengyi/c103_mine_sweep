import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_diamond_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_value_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';

import '../../../mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import '../../../mine_sweep_utils/ms_tba/ms_tba_utils.dart';

class MsP2DiamondCon extends MsBaseCon{
  List<String> alreadyExchangeList=[];
  
  @override
  void onInit() {
    super.onInit();
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.gem_page,);
    _getAlreadyExchangeList();
  }
  
  String getIcon(GemList bean){
    var num = bean.num??0;
    if(num<=6){
      return "diamond4";
    }else if(num<=20){
      return "diamond5";
    }else{
      return "diamond6";
    }
  }
  
  bool checkHasExchange(int money)=>alreadyExchangeList.contains("$money");
  
  bool checkHasDiamond(int diamond)=>p2DiamondNum.getData()>=diamond;
  
  String checkBtnIcon(GemList bean){
    if(checkHasExchange(bean.money??0)){
      return "diamond11";
    }
    if(checkHasDiamond(bean.num??0)){
      return "diamond8";
    }
    return "diamond9";
  }

  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickCollect(GemList bean){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.gem_collect_c,);
    var money = bean.money??0;
    var diamondNum = bean.num??0;
    if(!checkHasDiamond(diamondNum)){
      showToast("You don't have enough gem");
      return;
    }
    if(checkHasExchange(money)){
      showToast("You have already redeemed");
      return;
    }
    P2UserInfoUtils.instance.updateDiamond(-diamondNum);
    alreadyExchangeList.add("${bean.money}");
    P2UserInfoUtils.instance.updateCoinsNum(money.toDouble());
    p2DiamondExchangeRecord.saveData(alreadyExchangeList.join(","));
    update(["list"]);
  }

  String getBtnStr(GemList bean){
    var money = bean.money??0;
    if(checkHasExchange(money)){
      return "Received";
    }
    return "Collect";
  }
  
  _getAlreadyExchangeList(){
    try{
      var list = p2DiamondExchangeRecord.getData().split(",");
      alreadyExchangeList.clear();
      alreadyExchangeList.addAll(list);
    }catch(e){
      
    }
  }
}