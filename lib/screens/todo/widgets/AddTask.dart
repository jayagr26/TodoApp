import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/todo.dart';
import '../../../providers/todolist_provider.dart';

class AddTask extends StatefulWidget {
  AddTask({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
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
                    if (task.isNotEmpty && task.length > 4) {
                      Provider.of<TodoListModel>(context, listen: false)
                          .add(Todo(task: task));
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        submitted = true;
                      });
                    }
                  },
                  child: const Text('ADD'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
