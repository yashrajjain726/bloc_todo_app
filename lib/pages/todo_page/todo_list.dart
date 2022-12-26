import 'package:bloc_todo_app/cubits/filter_todos/filter_todos_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilterTodosCubit>().state.filteredTodos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        return Dismissible(
          background: showBackground(0),
          secondaryBackground: showBackground(1),
          key: ValueKey(todos[index].id),
          child: Text(
            todos[index].desc,
            style: const TextStyle(fontSize: 20),
          ),
        );
      },
    );
  }

  showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
