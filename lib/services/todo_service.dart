import 'package:todo_list_sqflite/model/todo.dart';
import 'package:todo_list_sqflite/repositories/repository.dart';

class TodoService {
  Repository? _repository;
  TodoService() {
    _repository = Repository();
  }

  saveTodo(Todo todo) async {
    return await _repository!.insertData('Todos', todo.todoMap());
  }

  readTodo() async {
    return await _repository!.readData('Todos');
  }
}
