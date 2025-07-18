import 'package:flutter_tba_info/flutter_tba_info.dart';

class MsHead{
  Future<Map<String,dynamic>> getHeadMap(String logId)async{
    var allege = await FlutterTbaInfo.instance.getIdfv();
    return {
      "allege":allege,
      "squid" :logId,
    };
  }
}