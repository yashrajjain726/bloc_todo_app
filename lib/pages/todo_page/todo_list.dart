import 'package:bloc_todo_app/cubits/filter_todos/filter_todos_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:bloc_todo_app/pages/todo_page/search_and_filter_todos.dart';
import 'package:bloc_todo_app/pages/todo_page/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilterTodosCubit>().state.filteredTodos;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListCubit, TodoListState>(listener: (context, state) {
          context.read<FilterTodosCubit>().setFilteredTodos(
              context.read<TodoFilterCubit>().state.filter,
              state.listTodos,
              context.read<TodoSearchCubit>().state.searchTerm);
        }),
        BlocListener<TodoFilterCubit, TodoFilterState>(
            listener: (context, state) {
          context.read<FilterTodosCubit>().setFilteredTodos(
              state.filter,
              context.read<TodoListCubit>().state.listTodos,
              context.read<TodoSearchCubit>().state.searchTerm);
        }),
        BlocListener<TodoSearchCubit, TodoSearchState>(
            listener: (context, state) {
          context.read<FilterTodosCubit>().setFilteredTodos(
              context.read<TodoFilterCubit>().state.filter,
              context.read<TodoListCubit>().state.listTodos,
              state.searchTerm);
        }),
      ],
      child: ListView.separated(
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
              onDismissed: (_) {
                context.read<TodoListCubit>().removeTodos(todos[index]);
              },
              confirmDismiss: (_) {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Are you Sure?'),
                        content: const Text('Do you really want to delete?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('No')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Yes'))
                        ],
                      );
                    },
                    barrierDismissible: false);
              },
              child: TodoItem(
                todo: todos[index],
              ));
        },
      ),
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
