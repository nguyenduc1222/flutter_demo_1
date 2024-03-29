class Todo {
  late int _id;
  late String _content;

  Todo.fromData(id, content) {
    _id = id;
    _content = content;
  }

  Todo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _content = json['content'];
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String, dynamic> toMap() {
    return {'id': _id, 'content': _content};
  }

  Map<String, dynamic> toJson() {
    return {'id': _id, 'content': _content};
  }
}
