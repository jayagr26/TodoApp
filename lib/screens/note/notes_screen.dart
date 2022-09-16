import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes Page'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/todo');
          },
          icon: Icon(Icons.menu),
        ),
      ),
      body: Center(
        child: Text('Hello in Notes'),
      ),
    );
  }
}
