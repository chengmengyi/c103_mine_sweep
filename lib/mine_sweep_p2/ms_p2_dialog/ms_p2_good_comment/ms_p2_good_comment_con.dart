import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';

class MsP2GoodCommentCon extends MsBaseCon{
  var showFinger=true,clickIndex=-1;

  clickStar(int index)async{
    clickIndex=index;
    showFinger=false;
    update(["list","finger"]);
  }

  clickSure(Function(int index) clickStarCallback){
    if(clickIndex<0){
      return;
    }
    MsRouterUtils.instance.back();
    clickStarCallback.call(clickIndex);
  }

  clickClose(){
    MsRouterUtils.instance.back();
  }
}