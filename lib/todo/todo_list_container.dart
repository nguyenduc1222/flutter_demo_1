import 'package:flutter/material.dart';
import 'todo_header.dart';
import 'todo_list.dart';

class TodoListContainer extends StatelessWidget {
  const TodoListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(color: Colors.red),
      child: Column(
        children: <Widget>[
          TodoHeader(),
          Expanded(child: TodoList()),
        ],
      ),
    );
  }
}
