import 'dart:async';
import 'dart:math';
import 'package:my_flutter_01/base/base_bloc.dart';
import 'package:my_flutter_01/base/base_event.dart';
import 'package:my_flutter_01/db/todo_table.dart';
import 'package:my_flutter_01/event/update_todo_event.dart';

import '../event/add_todo_event.dart';
import '../event/delete_todo_event.dart';
import '../model/todo.dart';

class TodoBloc extends BaseBloc {
  final TodoTable _todoTable = TodoTable();

  final StreamController<List<Todo>> _todoListStreamController =
      StreamController<List<Todo>>();

  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;

  final _randomInt = Random();
  List<Todo> _todoListData = <Todo>[];

  initData() async {
    _todoListData = await _todoTable.selectAllTodo();
    if (_todoListData.isEmpty) {
      return;
    }
    _todoListStreamController.sink.add(_todoListData);
  }

  _addTodo(Todo todo) async {
    // insert to db
    await _todoTable.insertTodo(todo);

    _todoListData.add(todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) async {
    await _todoTable.deleteTodo(todo);
    _todoListData.remove(todo);
    _todoListStreamController.sink.add(_todoListData);
  }

  _updateTodo(Todo todo) async {
    await _todoTable.updateTodo(todo);

    if (_todoListData.isEmpty) {
      _todoListData = await _todoTable.selectAllTodo();
    }

    _todoListData[
        _todoListData.indexWhere((element) => element.id == todo.id)] = todo;

    _todoListStreamController.sink.add(_todoListData);
  }

  @override
  void dispatchEvent(BaseEvent event) {
    if (event is AddTodoEvent) {
      // Add todo
      Todo todo = Todo.fromData(_randomInt.nextInt(1000000), event.content);
      _addTodo(todo);
    } else if (event is DeleteTodoEvent) {
      // Delete todo
      print("Delete event");
      _deleteTodo(event.todo);
    } else if (event is UpdateTodoEvent) {
      // Update todo
      print("Update event");
      _updateTodo(event.todo);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _todoListStreamController.close();
  }
}
