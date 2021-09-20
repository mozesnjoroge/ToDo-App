import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/helpers/drawer_navigation.dart';
import 'package:todo_list_sqflite/model/todo.dart';
import 'package:todo_list_sqflite/screens/todo_screen.dart';
import 'package:todo_list_sqflite/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getAllTodos();
  }

  // ignore: override_on_non_overriding_member
  List<Todo>? _todoList = <Todo>[];
  TodoService readTodoService = TodoService();

  getAllTodos() async {
    var todoItems = await readTodoService.readTodo();
    var todoModel = Todo();
    setState(() {
      todoItems.forEach((todo) {
        todoModel.id = todo['id'];
        todoModel.title = todo['title'];
        todoModel.todoDate = todo['todoDate'];
        todoModel.category = todo['category'];
        todoModel.isFinished = todo['isFinished'];
        todoModel.description = todo['description'];
      });
      _todoList!.add(todoModel);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List SQFlite'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                child: ListTile(
                  title: Text('${_todoList![index].title}'),
                  subtitle: Text('${_todoList![index].description}'),
                  trailing: Text('${_todoList![index].todoDate}'),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
      ),
    );
  }
}
