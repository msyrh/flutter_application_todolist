import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Title:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(todo.title),
                        SizedBox(height: 15),
                        const Text(
                          "Description:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(todo.description),
                        SizedBox(height: 15),
                        const Text(
                          "Created:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "${DateFormat("dd MMM yyyy hh:mm").format(todo.cdt.toLocal())} (${todo.udt == null ? 'not yet' : timeago.format(todo.cdt.toLocal())}) "),
                        SizedBox(height: 15),
                        const Text(
                          "Completed:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                            "${DateFormat("dd MMM yyyy hh:mm").format(todo.udt!.toLocal())} (${todo.udt == null ? 'not yet' : timeago.format(todo.udt!.toLocal())}) "),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
