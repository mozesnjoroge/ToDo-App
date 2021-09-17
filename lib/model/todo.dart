class Todo {
  int? id;
  String? title;
  String? description;
  String? category;
  String? todoDate;
  int? isFinished;

  todoMap() {
    var todoDataMap = Map<String, dynamic>();
    todoDataMap['id'] = id;
    todoDataMap['title'] = title;
    todoDataMap['description'] = description;
    todoDataMap['category'] = category;
    todoDataMap['todoDate'] = todoDate;
    todoDataMap['isFinished'] = isFinished;

    return todoDataMap;
  }
}
