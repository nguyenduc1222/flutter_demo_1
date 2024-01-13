import 'package:flutter/material.dart';
import 'package:my_flutter_01/event/update_todo_event.dart';
import 'package:provider/provider.dart';
import '../bloc/todo_bloc.dart';
import '../event/add_todo_event.dart';
import '../model/todo.dart';

class TodoScreen extends StatelessWidget {
  final Todo? todo;

  const TodoScreen({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<TodoBloc>(context);
    final contentController = TextEditingController();

    if (todo != null) {
      contentController.text = todo!.content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? 'Add a todo' : 'Edit todo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: Center(
              child: Text('What are you thinking about?'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: TextFormField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                  hintText: 'Context',
                  labelText: 'Content',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              keyboardType: TextInputType.multiline,
              onChanged: (str) {},
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () async {
                  final content = contentController.value.text;
                  if (content.isEmpty) {
                    return;
                  }
                  // TODO save or update
                  // final Todo todo = Todo.fromData(todo!.id, content);
                  if (todo == null) {
                    bloc.event.add(AddTodoEvent(content));
                  } else {
                    todo?.content = content;

                    print('Update test');
                    bloc.event.add(UpdateTodoEvent(todo!));
                  }

                  print('Update test');

                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    shape:
                        MaterialStateProperty.all(const RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )))),
                child: Text(todo == null ? 'Save' : 'Edit'),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
