import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_task_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_cash_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';

class CashSuccessCon extends MsBaseCon{

  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickBtn(MsP2CashTaskBean? bean)async{
    showToast("Congratulations! Your withdrawal was successful.");
    await MsP2CashUtils.instance.deleteCashTask(bean);
    MsRouterUtils.instance.back();
  }
}