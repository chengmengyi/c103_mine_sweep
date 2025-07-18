import 'dart:io';

import 'package:flutter_tba_info/flutter_tba_info.dart';

class MsBaseEvent {
  Future<Map<String,dynamic>> getBaseMap(String logId)async{
    var suffuse = await FlutterTbaInfo.instance.getAndroidId();
    var mutt = await FlutterTbaInfo.instance.getDeviceModel();
    var needle = await FlutterTbaInfo.instance.getBrand();
    var dwarves = await FlutterTbaInfo.instance.getIdfa();
    var oedipus = await FlutterTbaInfo.instance.getAppVersion();
    var weal = await FlutterTbaInfo.instance.getSystemLanguage();
    var songbag = await FlutterTbaInfo.instance.getGaid();
    var rousseau = await FlutterTbaInfo.instance.getNetworkType();
    var allege = await FlutterTbaInfo.instance.getIdfv();
    var funny = Platform.isAndroid?"show":"adjourn";
    var environ = await FlutterTbaInfo.instance.getManufacturer();
    var hull = await FlutterTbaInfo.instance.getDistinctId();
    var maudlin = await FlutterTbaInfo.instance.getOsCountry();
    var fantod = await FlutterTbaInfo.instance.getBundleId();
    var corrode = DateTime.now().millisecondsSinceEpoch;
    var movie = await FlutterTbaInfo.instance.getOperator();
    var pave = await FlutterTbaInfo.instance.getOsVersion();
    return {
      "invasion":{
        "suffuse":suffuse,
        "mutt":mutt,
        "needle":needle,
        "dwarves":dwarves,
        "oedipus":oedipus,
        "weal":weal,
        "songbag":songbag,
        "rousseau":rousseau,
        "allege":allege,
        "funny":funny,
        "environ":environ,
        "hull":hull,
        "maudlin":maudlin,
        "fantod":fantod,
        "corrode":corrode,
        "squid":logId,
        "movie":movie,
        "pave":pave,
      }
    };
  }
}