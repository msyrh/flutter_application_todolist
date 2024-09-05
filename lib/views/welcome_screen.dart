import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_todo_screen.dart';
import 'todo_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset('assets/images/logo.png'),
            height: 150,
          ),
          const Center(
            child: Text(
              'Welcome to',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 22),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Todo',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: const Text(
              "My Today helps you stay organized and perform your tasks much faster.",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(height: 50),
          CustomButton(
            height: 50.0,
            onPressed: () {
              Get.to(() => TodoScreen());
            },
            color: Colors.blue,
            title: 'Add Todo',
            icon: Icons.add,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              height: 50.0,
              onPressed: () {
                Get.to(() => MyTodoScreen());
              },
              title: 'My Todos',
              icon: Icons.task)
        ],
      ),
    );
  }
}
