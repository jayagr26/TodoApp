import 'package:flutter/material.dart';
import 'package:todoapp/models/todo.dart';

class TodoListModel with ChangeNotifier {
  final _todolist = <Todo>[];

  List<Todo> get todoList => _todolist;

  void add(Todo todo) {
    _todolist.add(todo);
    notifyListeners();
  }
}
