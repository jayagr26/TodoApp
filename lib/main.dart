import 'package:flutter/material.dart';
import 'package:todoapp/providers/todolist_provider.dart';
import 'package:todoapp/screens/todo/todo_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TodoListModel(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}
