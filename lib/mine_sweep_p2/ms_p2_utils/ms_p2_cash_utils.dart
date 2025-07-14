import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_task_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_sql_utils.dart';

class CashTaskName{
  static const String task1Pass5="task1Pass5";
  static const String task2Use20Wild="task2Use20Wild";
  static const String task3Use20Tomado="task3Use20Tomado";
}

class MsP2CashUtils {
  static final MsP2CashUtils _utils = MsP2CashUtils();
  static MsP2CashUtils get instance => _utils;

  createCashTask(int cashTypeIndex,int cashAmount,String account)async{
    var list = await MsSqlUtils.instance.db?.query(SqlTableName.cashTask.name,where: '"cashTypeIndex" = ? AND "cashAmount" = ?',whereArgs: [cashTypeIndex,cashAmount]);
    if(list?.isNotEmpty==true){
      return;
    }
    var bean = MsP2CashTaskBean(
      cashTypeIndex: cashTypeIndex,
      cashAmount: cashAmount,
      account: account,
      cashTask: CashTaskName.task1Pass5,
      currentPro: 0,
      totalPro: 5,
    );
    await MsSqlUtils.instance.db?.insert(SqlTableName.cashTask.name, bean.toJson());
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateCashList);
  }

  Future<MsP2CashTaskBean?> queryCashTaskByCashTypeAndCashAmount(int cashTypeIndex,int cashAmount)async{
    var list = await MsSqlUtils.instance.db?.query(SqlTableName.cashTask.name,where: '"cashTypeIndex" = ? AND "cashAmount" = ?',whereArgs: [cashTypeIndex,cashAmount]);
    if(list?.isEmpty==true){
      return null;
    }
    return MsP2CashTaskBean.fromJson(list?.first);
  }
  
  updateCashTask(String taskName)async{
    var list = await MsSqlUtils.instance.db?.query(SqlTableName.cashTask.name,where: '"cashTask" = ? ',whereArgs: [taskName]);
    if(list?.isEmpty==true){
      return;
    }
    for (var value in (list??[])) {
      var bean = MsP2CashTaskBean.fromJson(value);
      if(bean.cashTask==CashTaskName.task3Use20Tomado&&(bean.currentPro??0)>=(bean.totalPro??0)){
        continue;
      }
      bean.currentPro=(bean.currentPro??0)+1;
      if((bean.currentPro??0)>=(bean.totalPro??0)&&bean.cashTask!=CashTaskName.task3Use20Tomado){
        bean.currentPro=0;
        var nextCashTaskName = _getNextCashTaskName(bean.cashTask);
        bean.cashTask=nextCashTaskName;
        bean.totalPro=_getCashTaskTotalPro(nextCashTaskName);
      }
      await MsSqlUtils.instance.db?.update(SqlTableName.cashTask.name, bean.toJson(),where: '"id" = ?',whereArgs: [value["id"]]);
    }
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateCashList);
  }

  deleteCashTask(MsP2CashTaskBean? bean)async{
    await MsSqlUtils.instance.db?.delete(SqlTableName.cashTask.name,where: '"cashTypeIndex" = ? AND "cashAmount" = ?',whereArgs: [bean?.cashTypeIndex,bean?.cashAmount]);
    MsEventUtils.instance.sendMsg(code: MsP2EventCode.updateCashList);
  }
  
  String _getNextCashTaskName(String? currentName){
    switch(currentName){
      case CashTaskName.task1Pass5: return CashTaskName.task2Use20Wild;
      case CashTaskName.task2Use20Wild: return CashTaskName.task3Use20Tomado;
      default: return "";
    }
  }
  
  int _getCashTaskTotalPro(String? currentName){
    switch(currentName){
      case CashTaskName.task1Pass5: return 5;
      case CashTaskName.task2Use20Wild: return 20;
      case CashTaskName.task3Use20Tomado: return 20;
      default: return 0;
    }
  }
}