part of 'filter_todos_bloc.dart';

abstract class FilterTodosEvent extends Equatable {
  const FilterTodosEvent();

  @override
  List<Object> get props => [];
}

class CalculateFilterTodosEvent extends FilterTodosEvent {
  final List<Todo> filteredTodos;
  CalculateFilterTodosEvent({
    required this.filteredTodos,
  });

  @override
  String toString() =>
      'CalculateFilterTodosEvent(filteredTodos: $filteredTodos)';
  @override
  List<Object> get props => [filteredTodos];
}
