part of 'todo_search_bloc.dart';

abstract class TodoSearchEvent extends Equatable {
  const TodoSearchEvent();

  @override
  List<Object> get props => [];
}

class SetSearchTermEvent extends TodoSearchEvent {
  final String searchTerm;
  SetSearchTermEvent({
    required this.searchTerm,
  });

  SetSearchTermEvent copyWith({
    String? searchTerm,
  }) {
    return SetSearchTermEvent(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  String toString() => 'SetSearchTermEvent(searchTerm: $searchTerm)';
}
