import 'package:bloc_todo_app/blocs/blocs.dart';
import 'package:bloc_todo_app/blocs/filter_todos/filter_todos_bloc.dart';
import 'package:bloc_todo_app/blocs/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/pages/todo_page/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilterTodosBloc>().state.filteredTodos;
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
            onDismissed: (_) {
              context
                  .read<TodoListBloc>()
                  .add(RemoveTodoEvent(todo: todos[index]));
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
