import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodos = [...state.listTodos, newTodo];
    emit(state.copyWith(listTodos: newTodos));
    print(state);
  }

  void editTodo(String id, String todoDesc) {
    final newTodos = state.listTodos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todoDesc, isCompleted: todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(listTodos: newTodos));
  }

  void toggleTodo(String id) {
    final newTodos = state.listTodos.map((Todo todo) {
      if (todo.id == id) {
        return Todo(desc: todo.desc, id: id, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(listTodos: newTodos));
  }

  void removeTodos(Todo todo) {
    final newTodos =
        state.listTodos.where((Todo t) => t.id != todo.id).toList();
    emit(state.copyWith(listTodos: newTodos));
  }
}
