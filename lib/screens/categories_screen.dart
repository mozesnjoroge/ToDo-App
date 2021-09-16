import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_sqflite/model/category.dart';
import 'package:todo_list_sqflite/screens/home_screen.dart';
import 'package:todo_list_sqflite/services/category_services.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}



class _CategoriesScreenState extends State<CategoriesScreen> {
@override
void initState() {
  super.initState();
  getAllCategories();
}
//controllers
var _categoryNameController = TextEditingController();
var _categoryDescriptionController = TextEditingController();

//services
var _category = Category();
var _categoryService = CategoryServices();

//read services
List<Category>? _categoryList = <Category>[];

getAllCategories() async {
  _categoryList = <Category>[];
  var categories = await _categoryService.readCategory();
  categories.forEach((category) {
    setState(() {
      var categoryModel = Category();
      categoryModel.id = category['id'];
      categoryModel.name = category['name'];
      categoryModel.description = category['description'];
      _categoryList!.add(categoryModel);
    });
  });
}

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
          onPressed: () async {
            _category.name = _categoryNameController.text;
            _category.description = _categoryDescriptionController.text;
            var result = await _categoryService.insertCategory(_category);
            print(result);
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
      body: ListView.builder(
          itemCount: _categoryList!.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.edit),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_categoryList![index].name}',
                    ),
                    Icon(Icons.delete, color: Colors.red),
                  ],
                ),
                subtitle: Text(
                  '${_categoryList![index].description}',
                ),
              ),
            );
          }),
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
