import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_task_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_cash_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';

class CashTaskCon extends MsBaseCon{
  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickBtn(){
    MsRouterUtils.instance.back();
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.showHomeIndex,intValue: 0);
  }

  String getIcon(MsP2CashTaskBean? bean){
    switch(bean?.cashTask){
      case CashTaskName.task1Pass5: return "task1";
      case CashTaskName.task2Use20Wild: return "task2";
      case CashTaskName.task3Use20Tomado: return "task3";
      default: return "";
    }
  }

  String getContentStr(MsP2CashTaskBean? bean){
    switch(bean?.cashTask){
      case CashTaskName.task1Pass5: return "Complete the game 5 more times";
      case CashTaskName.task2Use20Wild: return "Use 5 wild cards";
      case CashTaskName.task3Use20Tomado: return "Use 5 bomb";
      default: return "";
    }
  }
}