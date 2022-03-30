import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/update_todo_cubit.dart';
import 'package:test/home/model/todo.dart';

class EditTodoScreen extends StatelessWidget {
  final Todo todo;
  final _controller = TextEditingController();
  EditTodoScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = todo.title;
    return BlocListener<UpdateTodoCubit, UpdateTodoState>(
      listener: (context, state) {
        if (state is UpdateTodoError) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(state.error),
              );
            },
          );
        } else if (state is UpdateTodoUpdated) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Todo'),
          actions: [
            InkWell(
              onTap: () => {
                BlocProvider.of<UpdateTodoCubit>(context).deleteTodo(todo),
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(Icons.delete),
              ),
            )
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Padding _body(context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            autocorrect: true,
            autofocus: true,
            controller: _controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 2.0),
              hintText: 'Enter your task',
            ),
          ),
          SizedBox(height: 20.0),
          InkWell(
            onTap: () => {
              BlocProvider.of<UpdateTodoCubit>(context)
                  .updateTodo(todo, _controller.text)
            },
            child: _edditBtn(context),
          ),
        ],
      ),
    );
  }

  Container _edditBtn(context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          'Update Todo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
