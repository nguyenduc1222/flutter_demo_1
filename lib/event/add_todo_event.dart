import 'package:my_flutter_01/base/base_event.dart';

class AddTodoEvent extends BaseEvent {
  late String content;
  AddTodoEvent(this.content);
}
