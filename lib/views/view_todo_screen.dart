import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/todo/todo.dart';

class ViewTodoScreen extends StatelessWidget {
  const ViewTodoScreen({
    Key? key,
    required this.todo,
  }) : super(key: key);
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Column(children: [
        const SizedBox(
          height: 40,
        ),
        const Icon(
          Icons.task_outlined,
          size: 60,
        ),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [const Text("Title : "), Text(todo.title)],
              ),
              Row(
                children: [const Text("Description: "), Text(todo.description)],
              ),
              Row(
                children: [const Text("Created: "), Text(timeago.format(todo.cdt))],
              )
            ],
          ),
        )
      ]),
    );
  }
}
