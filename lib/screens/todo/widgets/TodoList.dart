import 'package:flutter/material.dart';

import '../../../models/todo.dart';
import 'TodoItem.dart';

class TodoList extends StatefulWidget {
  List<Todo> todos;
  TodoList({super.key, required this.todos});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TodoItem(
          task: widget.todos[index].task,
          index: index,
        );
      },
      itemCount: widget.todos.length,
    );
  }
}
