import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_voice_utils.dart';

class MsP2SetCon extends MsBaseCon{
  clickBg(){
    MsVoiceUtils.instance.setBgMusic();
    update(["bg"]);
  }

  clickVoice(){
    MsVoiceUtils.instance.setVoiceMusic();
    update(["voice"]);
  }

  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickPrivacy(){

  }

  clickHome(Function()? clickHome){
    MsRouterUtils.instance.back();
    clickHome?.call();
  }

  clickResume(Function()? clickResume){
    MsRouterUtils.instance.back();
    clickResume?.call();
  }
}