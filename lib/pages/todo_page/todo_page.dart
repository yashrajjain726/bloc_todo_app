import 'package:bloc_todo_app/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:bloc_todo_app/pages/todo_page/create_todo.dart';
import 'package:bloc_todo_app/pages/todo_page/todo_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(children: [
              TodoHeader(),
              CreateTodos(),
            ]),
          ),
        ),
      ),
    );
  }
}
