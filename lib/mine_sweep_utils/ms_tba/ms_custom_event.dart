import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_base_event.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';

class MsCustomEvent {
  Future<Map<String,dynamic>> getCustomMap(String logId,MsCustomEventName eventName,Map<String,dynamic>? params)async{
    var baseMap = await MsBaseEvent().getBaseMap(logId);
    baseMap["alfred"]=eventName.name;
    if(null!=params){
      baseMap["memoir"]=params;
    }
    return baseMap;
  }
}