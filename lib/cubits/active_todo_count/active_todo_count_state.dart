part of 'active_todo_count_cubit.dart';

class ActiveTodoCountState extends Equatable {
  final int count;
  ActiveTodoCountState({
    required this.count,
  });

  @override
  List<Object> get props => [count];

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(count: 0);
  }

  ActiveTodoCountState copyWith({
    int? count,
  }) {
    return ActiveTodoCountState(
      count: count ?? this.count,
    );
  }

  @override
  String toString() => 'ActiveTodoCountState(count: $count)';
}
