import 'dart:convert';
import 'package:applovin_max/src/ad_classes.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_ad_pos_id.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_custom_event_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';
import 'package:flutter_ad_ios_plugins/data/ad_info_data.dart';
import 'package:flutter_ad_ios_plugins/data/config_ad_data.dart';
import 'package:flutter_ad_ios_plugins/flutter_ios_ad_hep.dart';
import 'package:flutter_ad_ios_plugins/hep/ad_type.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_ad_callback.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_local_info.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/utils.dart';
import 'package:flutter_ad_ios_plugins/hep/ios_load_ad_result_callback.dart';
import 'package:flutter_check_af/flutter_check_af.dart';

class MsAdUtils{
  static final MsAdUtils _utils = MsAdUtils();
  static MsAdUtils get instance => _utils;

  initAd()async{
    try{
      var json = _getAdJson();
      var data = _getConfigAdData(json);
      FlutterIosAdHep.instance.initMax(
        maxKey: MsLocalInfo.maxKeyBase64.base64(),
        data: data,
        iosLoadAdResultCallback: IosLoadAdResultCallback(
          startLoadAdCallback: (info){
            MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.ad_request,params: {"ad_code_id":info?.adId??"","ad_format":info?.adType.name,"ad_platform":info?.adPlat??""});
          },
          loadAdSuccessCallback: (maxAd,info){},
          loadAdFailCallback: (info){},
        ),
      );
    }catch(e){
    }
  }

  //显示A包的广告
  showP111111Ad({
    required AdType adType,
    required Function() close,
}){
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      showToast("Advertisement display failed, please try again later");
      FlutterIosAdHep.instance.loadAdWhenNoCache(adType);
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
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
      ),
    );
  }

  //显示B包广告
  showP2222Ad({
    required AdType adType,
    required MsAdPosId msAdPosId,
    required Function() close,
  }){
    var showAd = MsP2ValueUtils.instance.showAd(adType);
    if(!showAd){
      close.call();
      return;
    }
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.ohqxn_ad_chance,params: {"ad_pos_id":msAdPosId.name,"ad_format":adType.name});
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      if(adType==AdType.reward){
        showToast("Advertisement display failed, please try again later");
      }else{
        close.call();
      }
      FlutterIosAdHep.instance.loadAdWhenNoCache(adType);
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: _initIosAdCallback(adType: adType, msAdPosId: msAdPosId, close: close),
    );
  }

  showOpennnnAd({
    required AdType adType,
    required MsAdPosId msAdPosId,
    required Function() close,
  }){
    MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.ohqxn_ad_chance,params: {"ad_pos_id":msAdPosId.name,"ad_format":adType.name});
    var resultData = FlutterIosAdHep.instance.getCacheResultData(adType);
    if(null==resultData){
      FlutterIosAdHep.instance.loadAdWhenNoCache(adType);
      close.call();
      return;
    }
    FlutterIosAdHep.instance.showAd(
      adType: adType,
      iosAdCallback: IosAdCallback(
        showSuccess: (ad,info){
          _uploadAdLevel(ad,msAdPosId);
          MsVoiceUtils.instance.pauseBgMusic();
          MsTbaUtils.instance.adEvent(ad: ad, bean: info, posId: msAdPosId);
        },
        showFail: (ad){
          MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.ohqxn_ad_impression_fail,params: {"ad_pos_id":msAdPosId.name,"ad_format":adType.name});
          close.call();
        },
        closeAd: (){
          MsVoiceUtils.instance.resumeBgMusic();
          close.call();
        },
        onAdRevenuePaidCallback: (ad,info){

        },
      ),
    );
  }

  _getAdJson(){
    var str=MsLocalInfo.adLocalJsonBase64.base64();
    if(adFirebaseConfig.getData().isNotEmpty){
      str=adFirebaseConfig.getData();
    }
    return jsonDecode(str);
  }

  _getMaxShowNum(json)=>json["xdsaiozl"];
  _getMaxClickNum(json)=>json["cceliiwq"];

  _getConfigAdData(json)=>ConfigAdData(
    maxShowNum: _getMaxShowNum(json),
    maxClickNum: _getMaxClickNum(json),
    newInterList: _getAdList(json["ohqxn_int_sence"]),
    newRewardList: _getAdList(json["ohqxn_rv_sence"]),
  );

  _initIosAdCallback({
    required AdType adType,
    required MsAdPosId msAdPosId,
    required Function() close,
}){
    return IosAdCallback(
      showSuccess: (ad,info){
        _uploadAdLevel(ad,msAdPosId);
        MsVoiceUtils.instance.pauseBgMusic();
        MsTbaUtils.instance.adEvent(ad: ad, bean: info, posId: msAdPosId);
      },
      showFail: (ad){
        showToast("Advertisement display failed, please try again later");
        MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.ohqxn_ad_impression_fail,params: {"ad_pos_id":msAdPosId.name,"ad_format":adType.name});
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

  _uploadAdLevel(MaxAd? ad, MsAdPosId msAdPosId){
    FlutterCheckAf.instance.uploadAdRevenue(ad?.networkName??"", ad?.revenue??0, ad?.adUnitId??"", msAdPosId.name);
    adShowNum.saveData(adShowNum.getData()+1);
    var adLevel = lastAdLevel.getData()+5;
    if(adShowNum.getData()>=adLevel){
      MsTbaUtils.instance.customEvent(eventName: MsCustomEventName.pv_dall,params: {"pv_numbers":adLevel});
      lastAdLevel.saveData(adLevel);
    }
  }

  updateAdInfo(){
    var json = _getAdJson();
    var data = _getConfigAdData(json);
    FlutterIosAdHep.instance.updateAdData(data);
  }
}