import 'package:c103_mine_sweep/mine_sweep_base/ms_base_con.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_bean/ms_p1_diamond_bean.dart';
import 'package:c103_mine_sweep/mine_sweep_p1/ms_p1_utils/p1_user_info_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage.dart';

class MsP1DiamondCon extends MsBaseCon{
  List<MsP1DiamondBean> list=[
    MsP1DiamondBean(icon: "diamond4", diamondNum: 9, coinsNum: 5000,),
    MsP1DiamondBean(icon: "diamond5", diamondNum: 18, coinsNum: 12000,),
    MsP1DiamondBean(icon: "diamond5", diamondNum: 36, coinsNum: 25000,),
    MsP1DiamondBean(icon: "diamond6", diamondNum: 72, coinsNum: 60000,),
  ];

  clickClose(){
    MsRouterUtils.instance.back();
  }

  clickCollect(MsP1DiamondBean bean){
    if(p1DiamondNum.getData()<bean.diamondNum){
      return;
    }
    P1UserInfoUtils.instance.updateDiamond(-bean.diamondNum);
    P1UserInfoUtils.instance.updateCoinsNum(bean.coinsNum);
    MsRouterUtils.instance.back();
  }
}