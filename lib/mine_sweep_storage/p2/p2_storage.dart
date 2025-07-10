import 'package:c103_mine_sweep/mine_sweep_storage/p2/p2_storage_name.dart';
import 'package:flutter_ad_ios_plugins/data/storage_data.dart';

StorageData<int> p2LevelNum=StorageData<int>(key: P2StorageName.p2LevelNum, defaultValue: 1);
StorageData<int> p2CoinsNum=StorageData<int>(key: P2StorageName.p2CoinsNum, defaultValue: 0);
StorageData<int> p2DiamondNum=StorageData<int>(key: P2StorageName.p2DiamondNum, defaultValue: 0);