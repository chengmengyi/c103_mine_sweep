import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_pos_id.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_base_event.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:applovin_max/applovin_max.dart';

class MsAdEvent{
  Future<Map<String,dynamic>> getAdMap(String logId,MaxAd? ad,AdInfoData? bean,MsAdPosId posId)async{
    var baseMap = await MsBaseEvent().getBaseMap(logId);
    baseMap["clone"]=(ad?.revenue??0)*1000000;
    baseMap["unction"]="USD";
    baseMap["ho"]=ad?.networkName??"";
    baseMap["haggle"]=bean?.adPlat??"";
    baseMap["hawkins"]=bean?.adId??"";
    baseMap["pretoria"]=posId.name;
    baseMap["vacua"]=bean?.adType.name;
    baseMap["baltic"]=ad?.revenuePrecision??"";
    baseMap["alfred"]="bullhead";
    return baseMap;
  }
}