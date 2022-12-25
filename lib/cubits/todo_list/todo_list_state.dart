part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  List<Todo> listTodos;
  TodoListState({
    required this.listTodos,
  });

  factory TodoListState.initial() {
    return TodoListState(listTodos: []);
  }

  @override
  List<Object> get props => [listTodos];

  @override
  String toString() => 'TodoListState(listTodos: $listTodos)';

  TodoListState copyWith({
    List<Todo>? listTodos,
  }) {
    return TodoListState(
      listTodos: listTodos ?? this.listTodos,
    );
  }
}
