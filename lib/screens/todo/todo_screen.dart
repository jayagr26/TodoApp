import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/screens/todo/widgets/AddTask.dart';
import 'package:todoapp/screens/todo/widgets/TodoList.dart';
import '../../models/todo.dart';
import '../../providers/todolist_provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApp'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
      ),
      body: Consumer<TodoListModel>(
        builder: ((context, value, child) => TodoList(todos: value.todoList)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: AddTask(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
