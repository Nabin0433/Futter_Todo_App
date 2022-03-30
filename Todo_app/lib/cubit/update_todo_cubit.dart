import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/cubit/todo_cubit.dart';
import 'package:test/home/model/todo.dart';
import 'package:test/shared/constant/constant_message.dart';
import 'package:test/shared/data/repository.dart';
part 'update_todo_state.dart';

class UpdateTodoCubit extends Cubit<UpdateTodoState> {
  final Repository repository;
  final TodoCubit todoCubit;

  UpdateTodoCubit({required this.repository, required this.todoCubit})
      : super(UpdateTodoInitial());

  void deleteTodo(Todo todo) {
    emit(UpdateTodoLoding());
    repository.deleteTodo(todo.id).then(
      (isDeleted) {
        if (isDeleted) {
          todoCubit.deleteTodo(todo);
          emit(UpdateTodoUpdated());
        } else {
          emit(UpdateTodoError(error: ComstantMessages.Update_error_Message));
        }
      },
    );
  }

  void updateTodo(Todo todo, String message) {
    print(message);
    if (message.isEmpty) {
      emit(UpdateTodoError(error: "Message is empty"));
      return;
    }
    repository.updateTodo(message, todo.id).then((isEdited) {
      if (isEdited) {
        todo.title = message;
        todoCubit.updateTodoList();
        emit(UpdateTodoUpdated());
      }
    });
  }
}
