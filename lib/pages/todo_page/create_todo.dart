import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTodos extends StatefulWidget {
  const CreateTodos({super.key});

  @override
  State<CreateTodos> createState() => _CreateTodosState();
}

class _CreateTodosState extends State<CreateTodos> {
  final TextEditingController todoController = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: todoController,
      decoration: InputDecoration(labelText: 'What to do ?'),
      onSubmitted: (String? todoDesc) {
        if (todoDesc != null && todoDesc.trim().isNotEmpty) {
          context.read<TodoListCubit>().addTodo(todoDesc);
          todoController.clear();
        }
      },
    );
  }
}
