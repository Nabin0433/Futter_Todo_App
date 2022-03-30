import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/home/model/todo.dart';
import 'package:test/shared/data/repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final Repository repository;

  TodoCubit({required this.repository}) : super(TodoInitial());

  fetchTodos() {
    emit(TodoLoding());
    Timer(
      const Duration(seconds: 0),
      () => {
        repository.fetchTodos().then(
          (todos) {
            if (todos.isEmpty) {
              emit(TodoError());
            } else {
              emit(TodoSuccess(todos: todos));
            }
          },
        )
      },
    );
  }

  void changeCompletion(Todo todo, bool isCompleted) {
    repository.changeCompletion(isCompleted, todo.id).then((isChanged) {
      if (isChanged) {
        todo.isCompleted = isCompleted;
        _updateTodo(todo);
      } else {
        emit(TodoError());
      }
    });
  }

  void _updateTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoSuccess) {
      emit(TodoSuccess(todos: currentState.todos));
    } else {
      emit(TodoError());
    }
  }

  void addTodo(Todo todo) {
    final currentState = state;
    if (currentState is TodoSuccess) {
      final todoList = currentState.todos;
      todoList.add(todo);
      emit(TodoSuccess(todos: todoList));
    } else {
      emit(TodoError());
    }
  }

  void deleteTodo(Todo todo) async {
    final currentState = state;
    if (currentState is TodoSuccess) {
      final todoList =
          currentState.todos.where((element) => element.id != todo.id).toList();
      emit(TodoSuccess(todos: todoList));
    } else {
      emit(TodoError());
    }
  }

  void updateTodoList() {
    final currentState = state;
    if (currentState is TodoSuccess)
      emit(TodoSuccess(todos: currentState.todos));
  }
}
