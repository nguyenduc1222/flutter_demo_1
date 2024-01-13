import 'package:flutter/material.dart';
import 'package:my_flutter_01/bloc/todo_bloc.dart';
import 'package:provider/provider.dart';

import 'db/todo_database.dart';
import 'todo/todo_list_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TodoDatabase.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Todo List'),
          ),
          body: Provider<TodoBloc>.value(
              value: TodoBloc(), child: TodoListContainer()),
        ));
  }
}
