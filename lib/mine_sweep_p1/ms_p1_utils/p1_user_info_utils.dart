import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/ms_p1_event_code.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_event/ms_event_utils.dart';

class P1UserInfoUtils{
  static final P1UserInfoUtils _utils = P1UserInfoUtils();
  static P1UserInfoUtils get instance => _utils;

  int getCurrentLevelNum(){
    var level = p1LevelNum.getData();
    int offset = (level - 1) % 20;
    if (offset < 10) {
      return offset + 1;
    } else {
      return offset + 1;
    }
  }

  String updateLevel(){
    updateDiamond(1);
    var nextLevel = _checkToNextLevelPage();
    MsEventUtils.instance.sendMsg(code: MsP1EventCode.updateLevel);
    if(nextLevel>=0){
      return _getRouterNameByLevel(nextLevel);
    }else{
      return "";
    }
  }

  updateDiamond(int addNum){
    p1DiamondNum.saveData(p1DiamondNum.getData()+addNum);
    MsEventUtils.instance.sendMsg(code: MsP1EventCode.updateDiamond);
  }

  int _checkToNextLevelPage(){
    var currentLevel = p1LevelNum.getData();
    int nextLevel = currentLevel + 1;
    int currentStage = (currentLevel - 1) ~/ 10;
    int nextStage = (nextLevel - 1) ~/ 10;
    p1LevelNum.saveData(nextLevel);
    var isNext = currentStage != nextStage;
    if(isNext){
      return nextLevel;
    }else{
      return -1;
    }
  }


  String _getRouterNameByLevel(int nextLevel){
    var i = nextLevel%20;
    if(i<=10){
      return MsP1RoutersName.play10;
    }
    // else if(i<=20){
    //   return RoutersNameA.play11_20;
    // }
    return "";
  }

  updateCoinsNum(int add){
    p1CoinsNum.saveData(p1CoinsNum.getData()+add);
    if(add==0){
      return;
    }
    MsEventUtils.instance.sendMsg(code: MsP1EventCode.updateCoins);
  }
}