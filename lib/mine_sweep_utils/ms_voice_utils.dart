import 'package:audioplayers/audioplayers.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/common/common_storage.dart';
enum MusicType{
  playwin,fapai,playfail,wild,xiaochu,feng1
}

class MsVoiceUtils {
  static final MsVoiceUtils _utils = MsVoiceUtils();
  static MsVoiceUtils get instance => _utils;

  final AudioPlayer _bgAudioPlayer=AudioPlayer();
  final AudioPlayer _voiceAudioPlayer=AudioPlayer();

  MsVoiceUtils(){
    _voiceAddListener();
  }

  playBgMusic(){
    if(bgMusicSwitch.getData()){
      _bgAudioPlayer.setReleaseMode(ReleaseMode.loop);
      _bgAudioPlayer.play(AssetSource("bg.MP3"));
    }
  }

  setBgMusic(){
    if(bgMusicSwitch.getData()){
      bgMusicSwitch.saveData(false);
      _bgAudioPlayer.pause();
    }else{
      bgMusicSwitch.saveData(true);
      playBgMusic();
    }
  }

  pauseBgMusic(){
    if(!bgMusicSwitch.getData()||_bgAudioPlayer.state!=PlayerState.playing){
      return;
    }
    _bgAudioPlayer.pause();
  }

  resumeBgMusic(){
    if(!bgMusicSwitch.getData()||_bgAudioPlayer.state==PlayerState.playing){
      return;
    }
    _bgAudioPlayer.resume();
  }

  setVoiceMusic(){
    voiceMusicSwitch.saveData(!voiceMusicSwitch.getData());
  }

  playMusic(MusicType type){
    if(!voiceMusicSwitch.getData()){
      return;
    }
    _voiceAudioPlayer.play(AssetSource("${type.name}.MP3"));
  }

  _voiceAddListener(){
    _voiceAudioPlayer.onPlayerStateChanged.listen((event) {
      if(bgMusicSwitch.getData()){
        if(event==PlayerState.playing){
          _bgAudioPlayer.pause();
        }else if(event==PlayerState.completed){
          _bgAudioPlayer.resume();
        }
      }
    });
  }
}