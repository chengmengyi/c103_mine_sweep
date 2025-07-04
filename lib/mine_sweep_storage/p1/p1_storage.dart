import 'package:c103_mine_sweep/mine_sweep_storage/p1/p1_storage_name.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';

StorageData<int> p1LevelNum=StorageData<int>(key: P1StorageName.p1LevelNum, defaultValue: 1);
StorageData<int> p1CoinsNum=StorageData<int>(key: P1StorageName.p1CoinsNum, defaultValue: 0);
StorageData<int> p1DiamondNum=StorageData<int>(key: P1StorageName.p1DiamondNum, defaultValue: 0);