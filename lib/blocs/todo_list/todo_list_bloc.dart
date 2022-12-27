import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoListEvent, TodoListState> {
  TodoListBloc() : super(TodoListState.initial()) {
    on<AddTodoEvent>(_addTodo);
    on<EditTodoEvent>(_editTodo);
    on<ToggleTodoEvent>(_toggleTodo);
    on<RemoveTodoEvent>(_removeTodo);
  }

  _addTodo(AddTodoEvent event, Emitter<TodoListState> emit) {
    final newTodo = Todo(desc: event.todoDesc);
    final newTodos = [...state.listTodos, newTodo];
    emit(state.copyWith(listTodos: newTodos));
    print(state);
  }

  _editTodo(EditTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.listTodos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
            id: event.id, desc: event.todoDesc, isCompleted: todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(listTodos: newTodos));
  }

  _toggleTodo(ToggleTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos = state.listTodos.map((Todo todo) {
      if (todo.id == event.id) {
        return Todo(
            desc: todo.desc, id: event.id, isCompleted: !todo.isCompleted);
      }
      return todo;
    }).toList();
    emit(state.copyWith(listTodos: newTodos));
  }

  _removeTodo(RemoveTodoEvent event, Emitter<TodoListState> emit) {
    final newTodos =
        state.listTodos.where((Todo t) => t.id != event.todo.id).toList();
    emit(state.copyWith(listTodos: newTodos));
  }
}
