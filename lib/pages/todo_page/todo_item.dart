import 'package:bloc_todo_app/blocs/todo_list/todo_list_bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool _error = false;
              textEditingController.text = widget.todo.desc;
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: textEditingController,
                    autofocus: true,
                    decoration: InputDecoration(
                        errorText: _error ? 'Value cannot be empty' : null),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          setState(
                            () {
                              _error = textEditingController.text.isEmpty;
                              if (!_error) {
                                context.read<TodoListBloc>().add(EditTodoEvent(
                                    id: widget.todo.id,
                                    todoDesc: textEditingController.text));
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                        child: const Text('Edit'))
                  ],
                );
              });
            });
      },
      leading: Checkbox(
          value: widget.todo.isCompleted,
          onChanged: (bool? checked) {
            context
                .read<TodoListBloc>()
                .add(ToggleTodoEvent(id: widget.todo.id));
          }),
      title: Text(widget.todo.desc),
    );
  }
}
