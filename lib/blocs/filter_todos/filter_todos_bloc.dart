import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_todo_app/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:bloc_todo_app/blocs/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/blocs/todo_search/todo_search_bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';

part 'filter_todos_event.dart';
part 'filter_todos_state.dart';

class FilterTodosBloc extends Bloc<FilterTodosEvent, FilterTodosState> {
  late final StreamSubscription todoFilterSubscription;
  late final StreamSubscription todoSearchSubscription;
  late final StreamSubscription todoListSubscription;
  final List<Todo> initialTodos;
  final TodoFilterBloc todoFilterBloc;
  final TodoSearchBloc todoSearchBloc;
  final TodoListBloc todoListBloc;
  FilterTodosBloc({
    required this.initialTodos,
    required this.todoFilterBloc,
    required this.todoSearchBloc,
    required this.todoListBloc,
  }) : super(FilterTodosState(filteredTodos: initialTodos)) {
    todoFilterSubscription =
        todoFilterBloc.stream.listen((TodoFilterState todoFilterState) {});

    todoSearchSubscription =
        todoSearchBloc.stream.listen((TodoSearchState todoSearchState) {});

    todoListSubscription =
        todoListBloc.stream.listen((TodoListState todoListState) {});

    on<CalculateFilterTodosEvent>((event, emit) {
      emit(state.copyWith(filteredTodos: event.filteredTodos));
    });
  }

  void setFilteredTodos() {
    List<Todo> _filteredTodos;
    switch (todoFilterBloc.state.filter) {
      case Filter.active:
        _filteredTodos = todoListBloc.state.listTodos
            .where((Todo todo) => !todo.isCompleted)
            .toList();
        break;
      case Filter.completed:
        _filteredTodos = todoListBloc.state.listTodos
            .where((Todo todo) => todo.isCompleted)
            .toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todoListBloc.state.listTodos;
        break;
    }

    if (todoSearchBloc.state.searchTerm.isNotEmpty) {
      _filteredTodos = todoListBloc.state.listTodos
          .where((Todo todo) =>
              todo.desc.toLowerCase().contains(todoSearchBloc.state.searchTerm))
          .toList();
    }
    add(CalculateFilterTodosEvent(filteredTodos: _filteredTodos));
  }

  @override
  Future<void> close() {
    todoFilterSubscription.cancel();
    todoListSubscription.cancel();
    todoSearchSubscription.cancel();
    return super.close();
  }
}
