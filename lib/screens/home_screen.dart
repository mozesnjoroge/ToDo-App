import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/helpers/drawer_navigation.dart';
import 'package:todo_list_sqflite/screens/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List SQFlite'),
      ),
      drawer: DrawerNavigation(),
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
