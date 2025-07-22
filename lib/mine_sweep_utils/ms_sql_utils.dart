import 'package:sqflite/sqflite.dart';

enum SqlTableName{
  cashTask,tbaData
}

class MsSqlUtils {
  static final MsSqlUtils _utils=MsSqlUtils();
  static MsSqlUtils get instance => _utils;
  Database? db;

  initSql()async{
    db = await openDatabase(
      "ms.db",
      version: 1,
      onCreate: (db,version)async{
        db.execute('CREATE TABLE ${SqlTableName.cashTask.name} (id INTEGER PRIMARY KEY AUTOINCREMENT, cashTypeIndex INTEGER, cashAmount INTEGER, account TEXT, cashTask TEXT, currentPro INTEGER, totalPro INTEGER)');
        db.execute('CREATE TABLE ${SqlTableName.tbaData.name} (id INTEGER PRIMARY KEY AUTOINCREMENT, dataJson TEXT)');
      },
      // onUpgrade: (db,oldVersion,newVersion){
      //   if(newVersion==2){
      //     _createVersion2DB(db);
      //   }else if(newVersion==3){
      //     _createVersion3DB(db);
      //   }
      // }
    );
  }
}