import 'package:test/home/model/todo.dart';
import 'package:test/shared/data/network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<List<Todo>> fetchTodos() async {
    final todos = await networkService.fetchTodos();
    return todos.map((e) => Todo.fromjson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompletion, int id) async {
    final patchObj = {
      "isCompleted": isCompletion.toString(),
    };
    return await networkService.patchTodo(patchObj, id);
  }

  Future<Todo> addTodo(String title) async {
    final todoObj = {"title": title, "isCompleted": false.toString()};
    final todoMap = await networkService.addTodo(todoObj);
    if (todoMap.isNotEmpty) {
      return Todo.fromjson(todoMap);
    }
    return Todo.fromjson(todoMap);
  }

  Future<bool> deleteTodo(int id) async {
    return await networkService.deleteTodo(id);
  }

  Future<bool> updateTodo(String message, int id) async {
    return await networkService.updateTodo(message, id);
  }
}
