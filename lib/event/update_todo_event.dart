import 'package:my_flutter_01/base/base_event.dart';

import '../model/todo.dart';

class UpdateTodoEvent extends BaseEvent {
  Todo todo;
  UpdateTodoEvent(this.todo);
}
