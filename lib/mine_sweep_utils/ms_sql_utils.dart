import 'package:sqflite/sqflite.dart';

enum SqlTableName{
  cashTask,
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