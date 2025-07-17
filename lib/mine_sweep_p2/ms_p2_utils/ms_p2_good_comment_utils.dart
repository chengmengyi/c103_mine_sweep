import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_good_comment/ms_p2_good_comment_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_dialog/ms_p2_good_comment/ms_p2_good_comment_succes/ms_p2_good_comment_succes_dialog.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';
import 'package:in_app_review/in_app_review.dart';

class MsP2GoodCommentUtils {
  static final MsP2GoodCommentUtils _utils=MsP2GoodCommentUtils();
  static MsP2GoodCommentUtils get instance => _utils;


  checkShowGoodGuide(){
    if(p2AlreadyShowGoodCommentDialog.getData()){
      return;
    }
    MsRouterUtils.instance.showDialog(
      child: MsP2GoodCommentDialog(
        clickStarCallback: (index){
          _goodCommentResult(index);
        },
      ),
    );
  }

  _goodCommentResult(int index)async{
    p2AlreadyShowGoodCommentDialog.saveData(true);
    if(index>=3){
      var instance = InAppReview.instance;
      if (await instance.isAvailable()) {
        instance.requestReview();
      }
      P2UserInfoUtils.instance.updateCoinsNum(5);
    }else{
      MsRouterUtils.instance.showDialog(child: MsP2GoodCommentSuccesDialog());
    }
  }
}