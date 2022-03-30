import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/cubit/todo_cubit.dart';
import 'package:test/shared/data/repository.dart';
part 'add_todo_state.dart';

class AddTodoCubit extends Cubit<AddTodoState> {
  final Repository repository;
  final TodoCubit todoCubit;

  AddTodoCubit({required this.repository, required this.todoCubit})
      : super(AddTodoInitial());

  addTodo(String title) {
    if (title.isEmpty) {
      emit(AddTodoerror(error: "Please enter a message"));
      return;
    }
    emit(AddTodoLoding());

    Timer(
      Duration(seconds: 2),
      () {
        repository.addTodo(title).then((todo) {
          todoCubit.addTodo(todo);
          emit(AddTodoCompleted());
        }).catchError((error) {
          emit(AddTodoerror(error: error.toString()));
        });
      },
    );
  }
}
