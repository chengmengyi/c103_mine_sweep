import 'dart:convert';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_local_info.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';

class MsAdUtils{
  static final MsAdUtils _utils = MsAdUtils();
  static MsAdUtils get instance => _utils;

  initAd()async{
    // try{
    //   var json = _getAdJson();
    //   var data = _getConfigAdData(json);
    //   FlutterIosAdHep.instance.initMax(maxKey: MsLocalInfo.maxKeyBase64.base64(), data: data);
    // }catch(e){
    // }
  }

  //显示A包的广告
  showP111111Ad({
    required AdType adType,
    required Function() close,
}){
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      showToast("Advertisement display failed, please try again later");
      FlutterIosAdHep.instance.loadAd(adType);
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: _initIosAdCallback(close),
    );
  }

  _getAdJson()=>jsonDecode(MsLocalInfo.adLocalJsonBase64.base64());

  _getMaxShowNum(json)=>json["xdsaiozl"];
  _getMaxClickNum(json)=>json["cceliiwq"];

  _getConfigAdData(json)=>ConfigAdData(
    maxShowNum: _getMaxShowNum(json),
    maxClickNum: _getMaxClickNum(json),
    oneRewardList: _getAdList(json["ohqxn_rv_one"]),
    oneInterList: [],
    twoRewardList: [],
    twoInterList: [],
  );

  _initIosAdCallback(Function() close){
    return IosAdCallback(
      showSuccess: (ad,info){
        MsVoiceUtils.instance.pauseBgMusic();
      },
      showFail: (ad){
        showToast("Advertisement display failed, please try again later");
      },
      closeAd: (){
        MsVoiceUtils.instance.resumeBgMusic();
        close.call();
      },
      onAdRevenuePaidCallback: (ad,info){

      },
    );
  }

  List<AdInfoData> _getAdList(List list){
    try{
      List<AdInfoData> resultList=[];
      for (var value in list) {
        resultList.add(
            AdInfoData(
              adId: value["kyzuhtcs"],
              adPlat: value["smmyldai"],
              adType: value["jkcdpuol"]=="reward"?AdType.reward:AdType.interstitial,
              expireTime: value["dbzcignv"],
              sort: value["qgehncva"],
            )
        );
      }
      return resultList;
    }catch(e){
      return [];
    }
  }
}