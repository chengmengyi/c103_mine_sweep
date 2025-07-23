import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage_name.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';

StorageData<int> p2LevelNum=StorageData<int>(key: P2StorageName.p2LevelNum, defaultValue: 1);
StorageData<int> p2DiamondNum=StorageData<int>(key: P2StorageName.p2DiamondNum, defaultValue: 0);
StorageData<int> p2WheelPro=StorageData<int>(key: P2StorageName.p2WheelPro, defaultValue: 0);
StorageData<int> p2UserId=StorageData<int>(key: P2StorageName.p2UserId, defaultValue: 0);
StorageData<int> p2Level12PlayCardNum=StorageData<int>(key: P2StorageName.p2Level12PlayCardNum, defaultValue: 0);
StorageData<int> p2LastMoneyLevel=StorageData<int>(key: P2StorageName.p2LastMoneyLevel, defaultValue: 0);

StorageData<bool> p2LastShowWheel=StorageData<bool>(key: P2StorageName.p2LastShowWheel, defaultValue: true);
StorageData<bool> p2ShowGuideUser=StorageData<bool>(key: P2StorageName.p2ShowGuideUser, defaultValue: true);
StorageData<bool> p2FirstGetCoins=StorageData<bool>(key: P2StorageName.p2FirstGetCoins, defaultValue: true);
StorageData<bool> p2FirstLaunchApp=StorageData<bool>(key: P2StorageName.p2FirstLaunchApp, defaultValue: true);
StorageData<bool> p2AlreadyShowGoodCommentDialog=StorageData<bool>(key: P2StorageName.p2AlreadyShowGoodCommentDialog, defaultValue: false);
StorageData<bool> p2InstallEvent=StorageData<bool>(key: P2StorageName.p2InstallEvent, defaultValue: false);
StorageData<bool> p2ShowCoinsFinger=StorageData<bool>(key: P2StorageName.p2ShowCoinsFinger, defaultValue: true);
StorageData<bool> p2AlreadyShowWildGuide=StorageData<bool>(key: P2StorageName.p2AlreadyShowWildGuide, defaultValue: false);
StorageData<bool> p2AlreadyShowTomadoGuide=StorageData<bool>(key: P2StorageName.p2AlreadyShowTomadoGuide, defaultValue: false);
StorageData<bool> p2AlreadyShowedReachDialog=StorageData<bool>(key: P2StorageName.p2AlreadyShowedReachDialog, defaultValue: false);

StorageData<double> p2CoinsNum=StorageData<double>(key: P2StorageName.p2CoinsNum, defaultValue: 0.0);

StorageData<String> p2DiamondExchangeRecord=StorageData<String>(key: P2StorageName.p2DiamondExchangeRecord, defaultValue: "");