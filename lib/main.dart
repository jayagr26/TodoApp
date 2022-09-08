import 'package:flutter/material.dart';
import 'package:todoapp/providers/todolist_provider.dart';
import 'models/todo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoListModel(),
        ),
      ],
      child: const MaterialApp(
        title: 'TodoApp',
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApp'),
      ),
      body: Consumer<TodoListModel>(
        builder: ((context, value, child) => TodoList(todos: value.todoList)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              final taskController = TextEditingController();

              return AlertDialog(
                content: TextFormField(
                  controller: taskController,
                  decoration: const InputDecoration(
                    labelText: 'Task',
                    border: OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String task = taskController.text;
                      if (task.isNotEmpty) {
                        Provider.of<TodoListModel>(context, listen: false)
                            .add(Todo(task: task));
                        Navigator.of(context).pop();
                      } else {}
                    },
                    child: const Text('Add Task'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
        return TodoItem(task: widget.todos[index].task);
      },
      itemCount: widget.todos.length,
    );
  }
}

class TodoItem extends StatefulWidget {
  String task;
  TodoItem({super.key, required this.task});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          Expanded(child: Text(widget.task)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
