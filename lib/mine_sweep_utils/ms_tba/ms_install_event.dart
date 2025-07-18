import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_base_event.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

class MsInstallEvent {
  Future<Map<String,dynamic>> getInstallMap(String logId)async{
    var baseMap = await MsBaseEvent().getBaseMap(logId);
    var referrerMap = await FlutterTbaInfo.instance.getReferrerMap();
    baseMap["minsk"]=referrerMap["build"];
    baseMap["cornet"]=referrerMap["referrer_url"];
    baseMap["halma"]=referrerMap["install_version"];
    baseMap["h"]=referrerMap["user_agent"];
    baseMap["tilth"]="syllabi";
    baseMap["macabre"]=referrerMap["referrer_click_timestamp_seconds"];
    baseMap["pyrrhic"]=referrerMap["install_begin_timestamp_seconds"];
    baseMap["soothe"]=referrerMap["referrer_click_timestamp_server_seconds"];
    baseMap["went"]=referrerMap["install_begin_timestamp_server_seconds"];
    baseMap["snag"]=referrerMap["install_first_seconds"];
    baseMap["pram"]=referrerMap["last_update_seconds"];
    baseMap["trade"]=referrerMap["google_play_instant"];
    baseMap["alfred"]="kid";
    return baseMap;
  }
}