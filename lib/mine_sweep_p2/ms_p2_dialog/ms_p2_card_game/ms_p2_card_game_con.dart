import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/get_coins/get_coins_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

class MsP2CardGameCon extends MsBaseCon{
  var cakClick=true;
  var addNum=MsP2ValueUtils.instance.getCardGamesReward();

  clickClose(Function(double addNum) dismissDialog){
    if(!cakClick){
      return;
    }
    MsRouterUtils.instance.back();
    dismissDialog.call(0);
  }

  clickCardCallback(Function(double addNum) dismissDialog)async{
    cakClick=false;
    await Future.delayed(Duration(milliseconds: 3000));
    MsRouterUtils.instance.back();
    dismissDialog.call(addNum);
  }
}