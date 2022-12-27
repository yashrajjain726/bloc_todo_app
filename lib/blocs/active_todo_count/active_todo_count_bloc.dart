import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/blocs/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_event.dart';
part 'active_todo_count_state.dart';

class ActiveTodoCountBloc
    extends Bloc<ActiveTodoCountEvent, ActiveTodoCountState> {
  late final StreamSubscription todoListSubsription;
  final int initialActiveTodoCount;
  final TodoListBloc todoListBloc;
  ActiveTodoCountBloc(
      {required this.initialActiveTodoCount, required this.todoListBloc})
      : super(ActiveTodoCountState(count: initialActiveTodoCount)) {
    todoListSubsription =
        todoListBloc.stream.listen((TodoListState todoListState) {
      final int currentActiveTodoCount = todoListState.listTodos
          .where((Todo todo) => !todo.isCompleted)
          .toList()
          .length;
      add(CalculateActiveTodoEvent(count: currentActiveTodoCount));
    });
    on<CalculateActiveTodoEvent>(
        (event, emit) => emit(state.copyWith(count: event.count)));
  }

  @override
  Future<void> close() {
    todoListSubsription.cancel();
    return super.close();
  }
}
