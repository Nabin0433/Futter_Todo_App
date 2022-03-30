class Todo {
  String title;
  bool isCompleted;
  int id;

  Todo.fromjson(Map json)
      : title = json["title"],
        isCompleted = json["isCompleted"] == "true",
        id = json["id"] as int;
}
