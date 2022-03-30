// ignore_for_file: file_names, unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/todo_cubit.dart';
import 'package:test/shared/constant/Strings.dart';
import 'package:test/shared/constant/TextStyles.dart';
import '../model/todo.dart';

class Todoscreen extends StatelessWidget {
  const Todoscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<TodoCubit>(context).fetchTodos();

    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          if (state is TodoSuccess) {
            final List<Todo> todos = (state).todos;
            return _TodoBuildSucess(todos: todos);
          } else if (state is TodoLoding) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: const Text('Todos'),
      actions: [
        InkWell(
          onTap: () => Navigator.pushNamed(context, RoutesNames.addTodo),
          child: const Padding(
            padding: const EdgeInsets.all(10),
            child: const Icon(CupertinoIcons.plus),
          ),
        )
      ],
    );
  }
}

class _TodoBuildSucess extends StatelessWidget {
  const _TodoBuildSucess({
    Key? key,
    required this.todos,
  }) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Colors.black54,
                ),
              ),
            ),
            child: Text(
              'List of Todos',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          SizedBox(
            height: 800,
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return _todo(todos[index], context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

InkWell _todo(Todo todo, context) {
  return InkWell(
    onTap: () => Navigator.pushNamed(
      context,
      RoutesNames.editTodo,
      arguments: todo,
    ),
    child: Dismissible(
      confirmDismiss: (e) async {
        if (e.toString() == 'DismissDirection.endToStart') {
          BlocProvider.of<TodoCubit>(context).changeCompletion(todo, false);
          return false;
        } else {
          BlocProvider.of<TodoCubit>(context).changeCompletion(todo, true);
          return false;
        }
      },
      background: Container(
        color: Colors.red[500],
        child: ListTile(
          leading: Icon(
            Icons.done_all_rounded,
          ),
          trailing: const Icon(Icons.undo_rounded),
        ),
      ),
      key: Key(todo.id.toString()),
      child: ListTile(
        leading: Icon(
          CupertinoIcons.text_bubble_fill,
          color: todo.isCompleted ? Colors.green[600] : Colors.red[600],
        ),
        trailing: Text(
          todo.isCompleted ? "Completed" : "Pending",
          style: todo.isCompleted
              ? ConstantTextStyles().complete
              : ConstantTextStyles().pending,
        ),
        title: Text(
          todo.title[0].toUpperCase() + todo.title.substring(1),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
        ),
      ),
    ),
  );
}
