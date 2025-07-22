import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_network_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_p2/ms_p2_utils/ms_p2_value_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_common_pages.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_p1_pages.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_p2_pages.dart';
import 'package:c103_mine_sweep/mine_sweep_routers/ms_routers_name.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_ad_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_sql_utils.dart';
import 'package:c103_mine_sweep/mine_sweep_utils/ms_tba/ms_tba_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spine_flutter/spine_flutter.dart';

void main() async{
  await initMs();
  await initMsP1();
  await initMsP2();
  runApp(const MyApp());
}

initMs()async{
  await initSpineFlutter();
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarDividerColor: null,
        statusBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
      )
  );
}

initMsP1()async{
  await MsAdUtils.instance.initAd();
}

initMsP2()async{
  await MsSqlUtils.instance.initSql();
  MsP2ValueUtils.instance.initValue();
  MsTbaUtils.instance.installEvent();
  MsTbaUtils.instance.sessionEvent();
  MsP2NetworkUtils.instance.setNetworkListener();
  MsTbaUtils.instance.queryHasFailTbaJson();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var size = const Size(375, 812);
    var title="MineSweep Solitaire";
    var initialRoute = MsCommonRoutersName.launch;
    var pages = MsP1Pages.list+MsCommonPages.list+MsP2Pages.list;
    return ScreenUtilInit(
      designSize: size,
      builder: (c,child)=>GetMaterialApp(
        title: title,
        enableLog: true,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        initialRoute: initialRoute,
        debugShowCheckedModeBanner: false,
        getPages: pages,
        defaultTransition: Transition.rightToLeft,
      ),
    );
  }
}
