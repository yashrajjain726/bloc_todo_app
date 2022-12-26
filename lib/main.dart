import 'package:bloc_todo_app/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:bloc_todo_app/cubits/filter_todos/filter_todos_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_search/todo_search_cubit.dart';
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
        BlocProvider<TodoFilterCubit>(create: (context) => TodoFilterCubit()),
        BlocProvider<TodoSearchCubit>(create: (context) => TodoSearchCubit()),
        BlocProvider<TodoListCubit>(create: (context) => TodoListCubit()),
        BlocProvider<ActiveTodoCountCubit>(
            create: (context) => ActiveTodoCountCubit(
                initialActiveTodoCount:
                    context.read<TodoListCubit>().state.listTodos.length,
                todoListCubit: BlocProvider.of<TodoListCubit>(context))),
        BlocProvider<FilterTodosCubit>(
            create: (context) => FilterTodosCubit(
                todoFilterCubit: BlocProvider.of<TodoFilterCubit>(context),
                todoSearchCubit: BlocProvider.of<TodoSearchCubit>(context),
                todoListCubit: BlocProvider.of<TodoListCubit>(context))),
      ],
      child: const MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        home: TodoPage(),
      ),
    );
  }
}
