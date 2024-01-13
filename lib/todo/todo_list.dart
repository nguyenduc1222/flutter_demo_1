import 'package:flutter/material.dart';
import 'package:my_flutter_01/bloc/todo_bloc.dart';
import 'package:my_flutter_01/event/delete_todo_event.dart';
import 'package:my_flutter_01/model/todo.dart';
import 'package:my_flutter_01/screens/todos_screen.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
          stream: bloc.todoListStream,
          builder: (context, snapshot) {
            var data = snapshot.data;
            if (snapshot.data == null) {
              data = <Todo>[];
            }

            switch (snapshot.connectionState) {
              case ConnectionState.active:
                if (data!.isEmpty) {
                  return Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      child: const Text(
                        'Empty',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            'Todo \'${data![index].content}\'',
                            style: const TextStyle(fontSize: 20),
                          ),
                          trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Edit
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Provider<TodoBloc>.value(
                                                      value: bloc,
                                                      child: TodoScreen(
                                                        todo: snapshot
                                                            .data![index],
                                                      ))));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue[400],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      bloc.event.add(DeleteTodoEvent(
                                          snapshot.data![index]));
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red[400],
                                    ),
                                  ),
                                ),
                              ]),
                        );
                      });
                }
              case ConnectionState.waiting:
                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: const Text(
                      'Empty',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              case ConnectionState.none:
              default:
                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: const CircularProgressIndicator(),
                  ),
                );
            }
          }),
    );
  }
}
