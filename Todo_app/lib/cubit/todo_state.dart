part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoding extends TodoState {}

class TodoSuccess extends TodoState {
  final List<Todo> todos;
  TodoSuccess({required this.todos});
}
 
class TodoError extends TodoState {}
