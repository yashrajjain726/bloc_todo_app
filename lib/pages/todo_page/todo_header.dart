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
        BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
          builder: (context, state) {
            return Text(
              '${state.count} items left',
              style: const TextStyle(fontSize: 20.0, color: Colors.redAccent),
            );
          },
        )
      ],
    );
  }
}
