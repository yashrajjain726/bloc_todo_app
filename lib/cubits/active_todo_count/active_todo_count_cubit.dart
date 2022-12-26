import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final TodoListCubit todoListCubit;
  final int initialActiveTodoCount;
  late final StreamSubscription todoListSUbscription;
  ActiveTodoCountCubit(
      {required this.todoListCubit, required this.initialActiveTodoCount})
      : super(ActiveTodoCountState(count: initialActiveTodoCount)) {
    todoListSUbscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      print(todoListState);
      final int currentActiveTodoCount = todoListState.listTodos
          .where((Todo todo) => !todo.isCompleted)
          .toList()
          .length;

      emit(state.copyWith(count: currentActiveTodoCount));
    });
  }

  @override
  Future<void> close() {
    todoListSUbscription.cancel();
    return super.close();
  }
}
