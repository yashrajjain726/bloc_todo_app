part of 'todo_filter_bloc.dart';

abstract class TodoFilterEvent extends Equatable {
  const TodoFilterEvent();

  @override
  List<Object> get props => [];
}

class ChangeFilterEvent extends TodoFilterEvent {
  final Filter filter;
  ChangeFilterEvent({
    required this.filter,
  });

  @override
  List<Object> get props => [filter];

  @override
  String toString() => 'ChangeFilterEvent(filter: $filter)';

  ChangeFilterEvent copyWith({
    Filter? filter,
  }) {
    return ChangeFilterEvent(
      filter: filter ?? this.filter,
    );
  }
}
