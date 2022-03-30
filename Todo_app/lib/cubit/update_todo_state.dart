part of 'update_todo_cubit.dart';

@immutable
abstract class UpdateTodoState {}

class UpdateTodoInitial extends UpdateTodoState {}

class UpdateTodoLoding extends UpdateTodoState {}

class UpdateTodoUpdated extends UpdateTodoState {}

class UpdateTodoError extends UpdateTodoState {
  final String error;
  UpdateTodoError({required this.error});
}
