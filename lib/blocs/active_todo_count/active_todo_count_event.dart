part of 'active_todo_count_bloc.dart';

abstract class ActiveTodoCountEvent extends Equatable {
  const ActiveTodoCountEvent();

  @override
  List<Object> get props => [];
}

class CalculateActiveTodoEvent extends ActiveTodoCountEvent {
  final int count;
  CalculateActiveTodoEvent({
    required this.count,
  });

  @override
  String toString() => 'CalculateActiveTodoEvent(count: $count)';
  @override
  List<Object> get props => [count];
}
