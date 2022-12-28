part of 'filter_todos_bloc.dart';

class FilterTodosState extends Equatable {
  final List<Todo> filteredTodos;
  FilterTodosState({
    required this.filteredTodos,
  });

  factory FilterTodosState.initial() {
    return FilterTodosState(filteredTodos: []);
  }

  FilterTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilterTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }

  @override
  String toString() => 'FilterTodosState(filteredTodos: $filteredTodos)';

  @override
  List<Object> get props => [filteredTodos];
}
