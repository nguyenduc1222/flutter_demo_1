import 'package:my_flutter_01/base/base_event.dart';

import '../model/todo.dart';

class DeleteTodoEvent extends BaseEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}
