import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_cash_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter/material.dart';

class InputAccountController extends MsBaseCon{
  var cashTypeIndex=0,cashAmount=0;
  TextEditingController textEditingController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    var map = MsRouterUtils.instance.getArguments();
    cashTypeIndex=map["cashTypeIndex"];
    cashAmount=map["cashAmount"];
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.cash_form_page,params: {"form_type":cashTypeIndex==0?"paypal":"cash"});
  }

  clickBtn()async{
    var content = textEditingController.text.trim();
    if(content.isEmpty){
      return;
    }
    if(cashTypeIndex==0){
      if(!isValidEmail(content)){
        showToast("The format you entered is incorrect.");
        return;
      }
    }else{
      if(content.length!=10){
        showToast("The format you entered is incorrect.");
        return;
      }
    }
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.cash_form_page_confirm,params: {"form_type":cashTypeIndex==0?"paypal":"cash"});
    hideKeyboard();
    await MsP2CashUtils.instance.createCashTask(cashTypeIndex, cashAmount, content);
    P2UserInfoUtils.instance.updateCoinsNum(-cashAmount);
    MsRouterUtils.instance.back();
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegex.hasMatch(email);
  }

  hideKeyboard(){
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}