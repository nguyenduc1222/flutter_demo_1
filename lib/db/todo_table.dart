import 'package:my_flutter_01/db/todo_database.dart';
import 'package:sqflite/sqflite.dart';
import '../model/todo.dart';

class TodoTable {
  static const TABLE_NAME = 'todo';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME (
      id INTEGER PRIMARY KEY,
      content TEXT
    )
  ''';

  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';

  Future<int> insertTodo(Todo todo) async {
    final Database? db = TodoDatabase.instance.database;
    return await db!.insert(
      TABLE_NAME,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTodo(Todo todo) async {
    final Database? db = TodoDatabase.instance.database;
    return await db!.update(
      TABLE_NAME,
      todo.toMap(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(Todo todo) async {
    final Database? db = TodoDatabase.instance.database;
    await db!.delete(TABLE_NAME, where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<List<Todo>> selectAllTodo() async {
    final Database? db = TodoDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db!.query('todo');

    return List.generate(maps.length, (index) {
      return Todo.fromData(maps[index]['id'], maps[index]['content']);
    });
  }
}
