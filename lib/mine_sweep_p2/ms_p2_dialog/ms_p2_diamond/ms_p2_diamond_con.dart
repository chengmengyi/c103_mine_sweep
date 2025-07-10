import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_bean/ms_p2_diamond_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/p2_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage.dart';

class MsP1DiamondCon extends MsBaseCon{
  List<MsP2DiamondBean> list=[
    MsP2DiamondBean(icon: "diamond4", diamondNum: 9, coinsNum: 5000,),
    MsP2DiamondBean(icon: "diamond5", diamondNum: 18, coinsNum: 12000,),
    MsP2DiamondBean(icon: "diamond5", diamondNum: 36, coinsNum: 25000,),
    MsP2DiamondBean(icon: "diamond6", diamondNum: 72, coinsNum: 60000,),
  ];

  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickCollect(MsP2DiamondBean bean){
    if(p2DiamondNum.getData()<bean.diamondNum){
      return;
    }
    P2UserInfoUtils.instance.updateDiamond(-bean.diamondNum);
    P2UserInfoUtils.instance.updateCoinsNum(bean.coinsNum);
    MsRouterUtils.instance.back();
  }
}