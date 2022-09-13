import 'package:flutter/material.dart';

class EditTask extends StatefulWidget {
  int index;
  EditTask({super.key, required this.index});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
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
                hintText: 'Enter New Task',
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
                          .edit(widget.index, Todo(task: task));
                      Navigator.of(context).pop();
                    } else {
                      setState(() {
                        submitted = true;
                      });
                    }
                  },
                  child: const Text('SAVE'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
