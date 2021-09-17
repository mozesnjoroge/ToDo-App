import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_sqflite/model/category.dart';
import 'package:todo_list_sqflite/screens/home_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

//global variable
  var category;
  Fluttertoast flutterToast = Fluttertoast();
  FToast fToast = FToast();
//controllers
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();
  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

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

  //toast message
  void _showToast() {
    Widget toast = Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.blueAccent),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(width: 5.0),
          Text('Task updated',style: TextStyle(color: Colors.white),),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]['name'] ??= 'No Name';
      _editCategoryDescriptionController.text =
          category[0]['description'] ??= 'No Description';
    });
    _editFormDialog(context);
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Category'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _editCategoryNameController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  hintText: 'Enter the category name',
                ),
              ),
              TextField(
                controller: _editCategoryDescriptionController,
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
              'Update',
              style: TextStyle(
                color: Colors.green[900],
              ),
            ),
            onPressed: () async {
              _category.id = category[0]['id'];
              _category.name = _editCategoryNameController.text;
              _category.description = _editCategoryDescriptionController.text;
              var result = await _categoryService.updateCategory(_category);
              print(result);
              Navigator.of(context).pop();
              fToast.init(context);
              _showToast();
              getAllCategories();
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
            return Padding(
              padding: EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 5.0,
                child: ListTile(
                  leading: IconButton(
                    icon: Icon(
                      Icons.edit,
                    ),
                    onPressed: () {
                      _editCategory(context, _categoryList![index].id);
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_categoryList![index].name}',
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '${_categoryList![index].description}',
                  ),
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
