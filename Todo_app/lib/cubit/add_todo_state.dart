part of 'add_todo_cubit.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}

class AddTodoLoding extends AddTodoState {}

class AddTodoCompleted extends AddTodoState {}

class AddTodoerror extends AddTodoState {
  final String error;
  AddTodoerror({required this.error});
}
