import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/controllers/todo/todo_controller.dart';
import 'package:flutter_application_todolist/views/view_todo_screen.dart';
import 'package:get/get.dart';

import '../models/todo/todo.dart';
import 'add_todo_screen.dart';

class MyTodoScreen extends StatelessWidget {
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.off(() => TodoScreen());
        },
        label: Row(
          children: const [
            Icon(Icons.add),
            SizedBox(width: 10),
            Text("Add todo"),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 45,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Icon(Icons.arrow_back_ios_new),
                ),
                const Text(
                  "My Todos",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              "Completed",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: _buildCompleted(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              "Remaining",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: _buildInCompleted(),
          )
        ],
      ),
    );
  }

  Widget _buildCompleted() {
    return Obx(
      () => Container(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: controller.done.length,
          itemBuilder: (context, index) {
            Todo todo = controller.done[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => ViewTodoScreen(todo: todo));
              },
              onLongPress: () {
                controller.toggleTodo(todo);
              },
              child: TodoCard(
                isDone: todo.isDone,
                title: todo.title,
                date: todo.cdt,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInCompleted() {
    return Obx(
      () => Container(
        child: ListView.builder(
            itemCount: controller.remaining.length,
            itemBuilder: (context, index) {
              Todo todo = controller.remaining[index];
              return GestureDetector(
                onLongPress: () {
                  controller.toggleTodo(todo);
                },
                child: TodoCard(
                  isDone: todo.isDone,
                  title: todo.title,
                  date: todo.cdt,
                ),
              );
            }),
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.title,
    required this.date,
    required this.isDone,
  }) : super(key: key);

  final String title;
  final DateTime date;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 20,
              spreadRadius: 1,
            )
          ],
          color: isDone ? Colors.green[50] : Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: Row(
              children: [
                Icon(
                  Icons.task_alt,
                  color: isDone ? Colors.green : Colors.grey,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ))
          ],
        ));
  }
}
