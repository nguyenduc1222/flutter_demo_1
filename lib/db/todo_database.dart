import 'package:my_flutter_01/db/todo_table.dart';
import 'package:sqflite/sqflite.dart';

class TodoDatabase {
  static const DB_NAME = 'todo.db';
  static const DB_VERSION = 1;

  static Database? _database;
  Database? get database {
    return _database;
  }

  TodoDatabase._internal();
  static final TodoDatabase instance = TodoDatabase._internal();

  init() async {
    var databasesPath = await getDatabasesPath();
    final path = databasesPath + DB_NAME;
    print(path);

    _database = await openDatabase(path, onCreate: (db, version) {
      initScripts.forEach((script) async {
        return await db.execute(script);
      });
    }, onUpgrade: (db, oldVersion, newVersion) {
      migrationScripts.forEach((script) async {
        return await db.execute(script);
      });
    }, version: DB_VERSION);
  }

  static const initScripts = [TodoTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [TodoTable.CREATE_TABLE_QUERY];
}
