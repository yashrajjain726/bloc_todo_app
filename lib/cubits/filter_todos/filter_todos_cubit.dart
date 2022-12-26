import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:bloc_todo_app/models/todo_model.dart';

part 'filter_todos_state.dart';

class FilterTodosCubit extends Cubit<FilterTodosState> {
  final initialFilterTodos;
  late final StreamSubscription todoFilterSubsription;
  late final StreamSubscription todoListSubsription;
  late final StreamSubscription todoSearchSubsription;
  final TodoFilterCubit todoFilterCubit;
  final TodoListCubit todoListCubit;
  final TodoSearchCubit todoSearchCubit;
  FilterTodosCubit({
    required this.todoFilterCubit,
    required this.todoListCubit,
    required this.todoSearchCubit,
    required this.initialFilterTodos,
  }) : super(FilterTodosState(filteredTodos: initialFilterTodos)) {
    todoFilterSubsription =
        todoFilterCubit.stream.listen((TodoFilterState todoFilterState) {
      setFilteredTodos();
    });
    todoListSubsription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      setFilteredTodos();
    });
    todoSearchSubsription =
        todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;
    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        _filteredTodos = todoListCubit.state.listTodos
            .where((Todo todo) => !todo.isCompleted)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListCubit.state.listTodos
            .where((Todo todo) => todo.isCompleted)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListCubit.state.listTodos;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      _filteredTodos = todoListCubit.state.listTodos
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }
    emit(state.copyWith(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoFilterSubsription.cancel();
    todoListSubsription.cancel();
    todoSearchSubsription.cancel();
    return super.close();
  }
}
