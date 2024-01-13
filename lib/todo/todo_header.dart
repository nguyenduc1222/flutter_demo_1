import 'package:flutter/material.dart';
import 'package:my_flutter_01/event/add_todo_event.dart';
import 'package:provider/provider.dart';
import '../bloc/todo_bloc.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var txtTodoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);

    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: txtTodoController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 1,
                    style: BorderStyle.none,
                  ),
                ),
                labelText: 'Task todo',
                hintText: 'Add todo',
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                fillColor: Colors.white70,
              ),
            ),
          ),
          SizedBox(
            width: 40,
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[200],
              iconColor: Colors.white,
            ),
            onPressed: () {
              bloc.event.add(AddTodoEvent(txtTodoController.text));
            },
            icon: Icon(Icons.add),
            label: Text(
              'ADD ',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
