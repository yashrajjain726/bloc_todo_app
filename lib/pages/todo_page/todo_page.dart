import 'package:bloc_todo_app/pages/todo_page/create_todo.dart';
import 'package:bloc_todo_app/pages/todo_page/search_and_filter_todos.dart';
import 'package:bloc_todo_app/pages/todo_page/todo_header.dart';
import 'package:bloc_todo_app/pages/todo_page/todo_list.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(children: const [
              TodoHeader(),
              CreateTodos(),
              SizedBox(
                height: 20,
              ),
              SearchAndFilterTodos(),
              SizedBox(
                height: 20,
              ),
              TodoList()
            ]),
          ),
        ),
      ),
    );
  }
}
