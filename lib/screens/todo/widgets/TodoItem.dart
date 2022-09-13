import 'package:flutter/material.dart';
import 'EditTask.dart';

class TodoItem extends StatefulWidget {
  String task;
  int index;

  TodoItem({super.key, required this.task, required this.index});

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
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        content: EditTask(
                      index: widget.index,
                    ));
                  },
                );
              },
              icon: const Icon(Icons.edit)),
        ],
      ),
    );
  }
}
