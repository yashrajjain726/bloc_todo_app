import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_todo_app/models/todo_model.dart';

part 'filter_todos_state.dart';

class FilterTodosCubit extends Cubit<FilterTodosState> {
  final initialFilterTodos;

  FilterTodosCubit({
    required this.initialFilterTodos,
  }) : super(FilterTodosState(filteredTodos: initialFilterTodos));

  void setFilteredTodos(Filter filter, List<Todo> todos, String searchTerm) {
    List<Todo> _filteredTodos;
    switch (filter) {
      case Filter.active:
        _filteredTodos = todos.where((Todo todo) => !todo.isCompleted).toList();
        break;
      case Filter.completed:
        _filteredTodos = todos.where((Todo todo) => todo.isCompleted).toList();
        break;
      case Filter.all:
      default:
        _filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      _filteredTodos = todos
          .where((Todo todo) => todo.desc.toLowerCase().contains(searchTerm))
          .toList();
    }
    emit(state.copyWith(filteredTodos: _filteredTodos));
  }
}
