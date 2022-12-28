import 'package:bloc_todo_app/blocs/active_todo_count/active_todo_count_bloc.dart';
import 'package:bloc_todo_app/blocs/blocs.dart';
import 'package:bloc_todo_app/blocs/filter_todos/filter_todos_bloc.dart';
import 'package:bloc_todo_app/blocs/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/blocs/todo_search/todo_search_bloc.dart';
import 'package:bloc_todo_app/pages/todo_page/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoFilterBloc>(create: (context) => TodoFilterBloc()),
        BlocProvider<TodoSearchBloc>(create: (context) => TodoSearchBloc()),
        BlocProvider<TodoListBloc>(create: (context) => TodoListBloc()),
        BlocProvider<ActiveTodoCountBloc>(
            create: (context) => ActiveTodoCountBloc(
                  todoListBloc: context.read<TodoListBloc>(),
                  initialActiveTodoCount:
                      context.read<TodoListBloc>().state.listTodos.length,
                )),
        BlocProvider<FilterTodosBloc>(
            create: (context) => FilterTodosBloc(
                  todoSearchBloc: context.read<TodoSearchBloc>(),
                  todoListBloc: context.read<TodoListBloc>(),
                  todoFilterBloc: context.read<TodoFilterBloc>(),
                  initialTodos: context.read<TodoListBloc>().state.listTodos,
                )),
      ],
      child: const MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        home: TodoPage(),
      ),
    );
  }
}
