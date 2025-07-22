import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/http/ms_http_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_local_info.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_sql_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_event.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_pos_id.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_base_event.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_head.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_install_event.dart';
import 'package:flutter_ad_ios_plugins/hep/hep.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:applovin_max/applovin_max.dart';

class MsTbaUtils {
  static final MsTbaUtils _utils = MsTbaUtils();
  static MsTbaUtils get instance => _utils;

  installEvent({int tryNum=5})async{
    if(p2InstallEvent.getData()){
      return;
    }
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await MsInstallEvent().getInstallMap(logId);
    var headMap = await MsHead().getHeadMap(logId);
    "tba---->install---->start--->$map".log();
    var httpResult = await MsHttpUtils.instance.requestPost(
      path: MsLocalInfo.tbaUrl,
      data: map,
      header: headMap,
    );
    "tba---->install---->result----${httpResult.success}--->$map".log();
    if(httpResult.success){
      p2InstallEvent.saveData(true);
    }else {
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 2000));
        installEvent(tryNum: tryNum-1);
      }else{
        saveFailTbaJson(map);
      }
    }
  }

  sessionEvent({int tryNum=5})async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await MsBaseEvent().getBaseMap(logId);
    var headMap = await MsHead().getHeadMap(logId);
    map["stadium"]={};
    "tba---->session---->start--->$map".log();
    var httpResult = await MsHttpUtils.instance.requestPost(
      path: MsLocalInfo.tbaUrl,
      data: map,
      header: headMap,
    );
    "tba---->session---->result----${httpResult.success}--->$map".log();
    if(httpResult.success){

    }else {
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 2000));
        sessionEvent(tryNum: tryNum-1);
      }else{
        saveFailTbaJson(map);
      }
    }
  }

  customEvent({
    required MsCustomEventName eventName,
    Map<String,dynamic>? params,
    int tryNum=5,
  })async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await MsCustomEvent().getCustomMap(logId, eventName, params);
    var headMap = await MsHead().getHeadMap(logId);
    "tba---->custom---->start--->$map".log();
    var httpResult = await MsHttpUtils.instance.requestPost(
      path: MsLocalInfo.tbaUrl,
      data: map,
      header: headMap,
    );
    "tba---->custom---->result----${httpResult.success}--->$map".log();
    if(httpResult.success){

    }else {
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 2000));
        customEvent(eventName: eventName,params: params,tryNum: tryNum-1);
      }else{
        saveFailTbaJson(map);
      }
    }
  }

  adEvent({
    required MaxAd? ad,
    required AdInfoData? bean,
    required MsAdPosId posId,
    int tryNum=5,
  })async{
    var logId = await FlutterTbaInfo.instance.getLogId();
    var map = await MsAdEvent().getAdMap(logId, ad, bean, posId);
    var headMap = await MsHead().getHeadMap(logId);
    "tba---->adEvent---->start--->$map".log();
    var httpResult = await MsHttpUtils.instance.requestPost(
      path: MsLocalInfo.tbaUrl,
      data: map,
      header: headMap,
    );
    "tba---->adEvent---->result----${httpResult.success}--->$map".log();
    if(httpResult.success){

    }else {
      if(tryNum>0){
        await Future.delayed(Duration(milliseconds: 2000));
        adEvent(ad: ad, bean: bean, posId: posId,tryNum: tryNum-1);
      }else{
        saveFailTbaJson(map);
      }
    }
  }

  saveFailTbaJson(Map<String,dynamic> map)async{
    MsSqlUtils.instance.db?.insert(SqlTableName.tbaData.name, map);
  }

  queryHasFailTbaJson()async{
    var list = await MsSqlUtils.instance.db?.query(SqlTableName.tbaData.name);
    if(list?.isEmpty==true){
      return;
    }
    "tba---->has fail json".log();
    var logId = await FlutterTbaInfo.instance.getLogId();
    var headMap = await MsHead().getHeadMap(logId);
    headMap["Content-Encoding"]="gzip";
    var httpResult = await MsHttpUtils.instance.requestPost(
      path: MsLocalInfo.tbaUrl,
      data: headMap,
      header: headMap,
      contentType: "application/json",
    );
    if(httpResult.success){
      MsSqlUtils.instance.db?.delete(SqlTableName.tbaData.name);
    }
  }
}