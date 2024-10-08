import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_todolist/models/todo/todo.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TodoController extends GetxController {
  var todos = [].obs;
  var done = [].obs;
  var remaining = [].obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();

  @override
  void onInit() {
    // TODO: implement onInit
    try {
      Hive.registerAdapter(TodoAdapter());
    } catch (error) {
      printError(info: "onInit : $error");
    }
    getTodos();
    super.onInit();
  }

  addTodo(Todo todo) async {
    todos.add(todo);
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
    print("Todo Object added $todos");
  }

  Future getTodos() async {
    Box box;
    print("Getting todos");
    try {
      box = Hive.box('db');
    } catch (error) {
      box = await Hive.openBox('db');
      printError(info: "getTodos: $error");
    }

    var tds = box.get('todos');
    print("TODOS $tds");
    if (tds != null) todos.value = tds;
    for (Todo todo in todos) {
      if (todo.isDone) {
        done.add(todo);
      } else {
        remaining.add(todo);
      }
    }
  }

  clearTodos() {
    try {
      Hive.deleteBoxFromDisk('db');
    } catch (error) {
      printError(info: "clearTodos: $error");
    }

    todos.value = [];
  }

  Future deleteTodo(Todo todo) async {
    var index = todos.indexOf(todo);
    if (index <= 0 ) return;
    print("delete ${todo.title}");

    todos.remove(todo);
    remaining.remove(todo);
    // done.remove(todo);

    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
    return;
  }

  toggleTodo(Todo todo) async {
    var index = todos.indexOf(todo);
    var editTodo = todos[index];
    editTodo.isDone = !editTodo.isDone;
    editTodo.udt = DateTime.now().toUtc();
    if (editTodo.isDone) {
      done.add(editTodo);
      remaining.remove(editTodo);
    } else {
      done.remove(editTodo);
      remaining.add(editTodo);
    }
    todos[index] = editTodo;
    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
  }

  updateTodo(Todo todo) async {
    var index = todos.indexWhere((td) => td.id == todo.id);
    var editTodo = todos[index];

    remaining.remove(editTodo);
    remaining.add(todo);

    todos[index] = todo;

    var box = await Hive.openBox('db');
    box.put('todos', todos.toList());
  }
}
