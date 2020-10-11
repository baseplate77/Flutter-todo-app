import 'package:sqflite/sqflite.dart' as sqf;
import 'package:path/path.dart' as path;

class DBHelper {

  static Future<sqf.Database> dataBase(String table) async{
    final dbPath = await sqf.getDatabasesPath();
    return sqf.openDatabase(path.join(dbPath, 'tasks.db'),
        onCreate: (db, version) {
          return db.execute('CREATE TABLE $table(id  TEXT PRIMARY KEY,task TEXT,isdone INTEGER,type TEXT )');
        }, version: 1);
  }

  static Future<sqf.Database> taskTypeDB(String table) async{
    final dbPath = await sqf.getDatabasesPath();
    return sqf.openDatabase(path.join(dbPath, 'taskType.db'),
        onCreate: (db, version) {
          return db.execute('CREATE TABLE $table(id  TEXT PRIMARY KEY, taskType TEXT)');
        }, version: 1);
  }

  static insertTaskType(String table, Map<String, dynamic> data) async {
    final db = await DBHelper.taskTypeDB(table);
    await db.insert(table, data,conflictAlgorithm: sqf.ConflictAlgorithm.replace);
  }

  static void updateTaskType(String table, Map<String, dynamic> data,String id)async{
    final db = await DBHelper.taskTypeDB(table);
    await db.update(table, data, where: 'id = ?',whereArgs: [id]);
  }

  static Future<List<Map<String,Object>>> getTaskType(String table) async{
    final db = await DBHelper.taskTypeDB(table);
    return db.query(table,);
  }


  static Future<void> deleteTaskTypeAndTask(String taskTable,String taskTypeTable,String taskType) async{
    final db = await DBHelper.dataBase(taskTable);
    final dbTt = await DBHelper.taskTypeDB(taskTypeTable);
    await dbTt.delete(taskTypeTable,where: 'taskType = ?',whereArgs: [taskType]);
    await db.delete(taskTable,where:'type = ?',whereArgs: [taskType]);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {

    final db = await DBHelper.dataBase(table);
    await db.insert(table, data,conflictAlgorithm: sqf.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String,Object>>> getData(String table) async{
    final db = await DBHelper.dataBase(table);
    return db.query(table,);
  }

  static Future<void> delete(String table,String id) async{
    final db = await DBHelper.dataBase(table);
    db.delete(table,where: 'id = ?',whereArgs: [id]);
  }
}
