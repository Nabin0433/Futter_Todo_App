// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/cubit/add_todo_cubit.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocListener<AddTodoCubit, AddTodoState>(
        listener: (context, state) {
          if (state is AddTodoerror) {
            print(state.error);
            showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Error'),
                  content: Text(state.error),
                );
              },
            );
          } else if (state is AddTodoCompleted) {
            Navigator.of(context).pop();
          }
        },
        child: _body(),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Add Todo',
      ),
    );
  }

  SingleChildScrollView _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter your task',
              ),
            ),
            SizedBox(height: 20.0),
            InkWell(
              onTap: () => BlocProvider.of<AddTodoCubit>(context)
                  .addTodo(_controller.text),
              child: _addBtn(),
            ),
          ],
        ),
      ),
    );
  }

  Container _addBtn() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: BlocBuilder<AddTodoCubit, AddTodoState>(
          builder: (context, state) {
            if (state is AddTodoLoding) {
              return CircularProgressIndicator(
                color: Colors.white,
              );
            } else {
              return Text(
                'Add Todos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
