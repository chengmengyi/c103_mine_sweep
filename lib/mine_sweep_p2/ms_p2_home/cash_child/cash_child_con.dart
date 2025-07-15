import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_list_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_cash_task_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/cash/cash_success/cash_success_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/cash/cash_task/cash_task_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/cash/no_money/no_money_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/guide/ms_p2_guide_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_cash_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_bean.dart';
import 'package:flutter/material.dart';

class CashChildCon extends MsBaseCon{
  var cashTypeIndex=0;
  List<MsP2CashListBean> cashList=[];
  GlobalKey firstAmountGlobalKey=GlobalKey();

  @override
  void onReady() {
    super.onReady();
    _initList();
  }

  clickCashType(index){
    if(cashTypeIndex==index){
      return;
    }
    cashTypeIndex=index;
    update(["page"]);
    _initList();
  }

  clickCash(MsP2CashListBean bean){
    if(null!=bean.cashTaskBean){
      var cashTaskBean = bean.cashTaskBean;
      if(cashTaskBean?.cashTask==CashTaskName.task3Use20Tomado&&(cashTaskBean?.currentPro??0)>=(cashTaskBean?.totalPro??0)){
        MsRouterUtils.instance.showDialog(
          child: CashSuccessDialog(
            bean: bean.cashTaskBean,
          ),
        );
        return;
      }
      MsRouterUtils.instance.showDialog(
        child: CashTaskDialog(
          bean: bean.cashTaskBean,
        ),
      );
      return;
    }
    if(p2CoinsNum.getData()<bean.cashAmount){
      MsRouterUtils.instance.showDialog(
        child: NoMoneyDialog(),
      );
      return;
    }
    MsRouterUtils.instance.toNamed(routersName: MsP2RoutersName.inputAccount,arguments: {"cashTypeIndex":cashTypeIndex,"cashAmount":bean.cashAmount,},);
  }

  String getCashTaskLeftStr(MsP2CashTaskBean? bean){
    switch(bean?.cashTask){
      case CashTaskName.task1Pass5: return "Complete the game ";
      case CashTaskName.task2Use20Wild: return "Use ";
      case CashTaskName.task3Use20Tomado: return "Use ";
      default: return "";
    }
  }

  String getCashTaskCenterStr(MsP2CashTaskBean? bean)=>"${bean?.currentPro??0}/${bean?.totalPro??0}";

  String getCashTaskRightStr(MsP2CashTaskBean? bean){
    switch(bean?.cashTask){
      case CashTaskName.task1Pass5: return " more times";
      case CashTaskName.task2Use20Wild: return " wild cards";
      case CashTaskName.task3Use20Tomado: return " bomb";
      default: return "";
    }
  }

  String getTopRightStr(MsP2CashListBean bean){
    if(null==bean.cashTaskBean){
      return "";
    }
    if(bean.cashTaskBean?.currentPro==bean.cashTaskBean?.totalPro){
      return "Success";
    }
    return "Progressing";
  }

  double getPro(MsP2CashTaskBean? bean){
    try{
      var d = (bean?.currentPro??0)/(bean?.totalPro??0);
      if(d>1){
        return 1;
      }else if(d<0){
        return 0;
      }else{
        return d;
      }
    }catch(e){
      return 0;
    }
  }

  @override
  bool registerEvent() => true;

  @override
  handleEventMessage(MsEventBean event) {
    switch(event.code){
      case MsP2EventCode.updateCoins:
        update(["coins"]);
        break;
      case MsP2EventCode.updateCashList:
        _initList();
        break;
      case MsP2EventCode.showCashGuide:
        _showCashGuide();
        break;
    }
  }

  _showCashGuide(){
    MsP2GuideUtils.instance.showStep5Guide(
      context: context,
      amountGlobalKey: firstAmountGlobalKey,
      dismissCallback: (){
        clickCash(cashList.first);
      },
    );
  }

  _initList()async{
    cashList.clear();
    var list = MsP2ValueUtils.instance.getCashList();
    for (var value in list) {
      var taskBean = await MsP2CashUtils.instance.queryCashTaskByCashTypeAndCashAmount(cashTypeIndex, value);
      cashList.add(MsP2CashListBean(cashAmount: value, cashTaskBean: taskBean));
    }
    update(["cash_list"]);
  }
}