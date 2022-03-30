import 'dart:convert';
import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "http://localhost:3000";

  Future<List<dynamic>> fetchTodos() async {
    try {
      final response = await get(Uri.parse(baseUrl + '/todo'));
      return jsonDecode(response.body) as List;
    } catch (err) {
      return [];
    }
  }

  Future<bool> patchTodo(Map<String, String> patchObj, int id) async {
    try {
      await patch(
        Uri.parse(baseUrl + '/todo/$id'),
        body: jsonEncode(patchObj),
        headers: {"Content-Type": "application/json"},
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> addTodo(Map<String, String> todoObj) async {
    try {
      final response = await post(
        Uri.parse(baseUrl + '/todo'),
        body: jsonEncode(todoObj),
        headers: {"Content-Type": "application/json"},
      );
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      await delete(Uri.parse(baseUrl + '/todo/$id'));
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<bool> updateTodo(String message, int id) async {
    try {
      await patch(
        Uri.parse(baseUrl + '/todo/$id'),
        body: jsonEncode({'title': message}),
        headers: {"Content-Type": "application/json"},
      );
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }
}
