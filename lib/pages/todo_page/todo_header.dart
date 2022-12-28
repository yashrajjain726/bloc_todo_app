import 'package:bloc_todo_app/blocs/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/active_todo_count/active_todo_count_cubit.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODOS',
          style: TextStyle(fontSize: 40),
        ),
        BlocListener<TodoListBloc, TodoListState>(
          listener: (context, state) {
            final int activeTodoCount = state.listTodos
                .where((Todo todo) => !todo.isCompleted)
                .toList()
                .length;

            context
                .read<ActiveTodoCountCubit>()
                .calculateActiveTodoCount(activeTodoCount);
          },
          child: BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
            builder: (context, state) {
              return Text(
                '${state.count} items left',
                style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
              );
            },
          ),
        )
      ],
    );
  }
}
