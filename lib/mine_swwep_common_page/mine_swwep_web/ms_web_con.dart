import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';

class MsWebCon extends MsBaseCon{
  late WebViewController controller;

  @override
  void onInit() {
    super.onInit();
    controller=WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  void onReady() {
    super.onReady();
    controller.loadRequest(Uri.parse(MsRouterUtils.instance.getArguments()["url"]));
  }
}