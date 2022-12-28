import 'package:bloc_todo_app/blocs/todo_filter/todo_filter_bloc.dart';
import 'package:bloc_todo_app/blocs/todo_search/todo_search_bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:bloc_todo_app/utils/debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndFilterTodos extends StatelessWidget {
  SearchAndFilterTodos({super.key});
  final debounce = Debounce(milliSeconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search Todos',
            border: InputBorder.none,
            filled: true,
            prefixIcon: Icon(
              Icons.search,
            ),
          ),
          onChanged: (String? newSearchTerm) {
            if (newSearchTerm != null) {
              debounce.run(() {
                context
                    .read<TodoSearchBloc>()
                    .add(SetSearchTermEvent(searchTerm: newSearchTerm));
              });
            }
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            filterButton(context, Filter.all),
            filterButton(context, Filter.active),
            filterButton(context, Filter.completed),
          ],
        )
      ],
    );
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
      onPressed: () {
        context.read<TodoFilterBloc>().add(ChangeFilterEvent(filter: filter));
      },
      child: Text(
        filter == Filter.all
            ? 'All'
            : filter == Filter.active
                ? 'Active'
                : 'Completed',
        style: TextStyle(
          fontSize: 18,
          color: textColor(context, filter),
        ),
      ),
    );
  }

  Color textColor(BuildContext context, Filter filter) {
    final currentFilter = context.watch<TodoFilterBloc>().state.filter;
    print(filter);
    return currentFilter == filter ? Colors.blue : Colors.grey;
  }
}
