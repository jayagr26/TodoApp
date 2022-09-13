import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
                content: AddTaskWidget(),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddTaskWidget extends StatefulWidget {
  AddTaskWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final TextEditingController taskController = TextEditingController();

  var submitted = false;

  String? get _errorText {
    final text = taskController.value.text;
    if (text.isEmpty) {
      return 'Task cannot be empty';
    }

    if (text.length < 5) {
      return 'Length Too Short';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: taskController,
      builder: (context, TextEditingValue value, __) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: taskController,
              decoration: InputDecoration(
                labelText: 'Task',
                border: const OutlineInputBorder(),
                errorText: submitted ? _errorText : null,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String task = taskController.text;
                    submitted = true;
                    if (task.isNotEmpty) {
                      Provider.of<TodoListModel>(context, listen: false)
                          .add(Todo(task: task));
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        submitted = true;
                      });
                    }
                  },
                  child: const Text('Add Task'),
                ),
              ],
            ),
          ],
        );
      },
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
