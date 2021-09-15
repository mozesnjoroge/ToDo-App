import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_sqflite/model/category.dart';
import 'package:todo_list_sqflite/screens/home_screen.dart';
import 'package:todo_list_sqflite/services/category_services.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

//controllers
var _categoryNameController = TextEditingController();
var _categoryDescriptionController = TextEditingController();

//services
var _category = Category();
var _categoryService = CategoryServices();

_showFormDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Categories Form'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Category',
                hintText: 'Enter the category name',
              ),
            ),
            TextField(
              controller: _categoryDescriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                hintText: 'Enter the category\'s description',
              ),
            ),
          ],
        ),
      ),
      actions: [
        OutlinedButton(
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.green[900],
            ),
          ),
          onPressed: () {
            _category.name = _categoryNameController.text;
            _category.description = _categoryDescriptionController.text;
            _categoryService.saveCategory(_category);
            Navigator.of(context).pop();
          },
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              //TODO name your routes and refactor this code
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            }),
        title: Text('Categories'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('These are your categories'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showFormDialog(context);
        },
        backgroundColor: Colors.blue,
      ),
    );
  }
}
