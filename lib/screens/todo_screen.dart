import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/model/category.dart';
import 'package:todo_list_sqflite/services/category_services.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<DropdownMenuItem<String>> _categories = <DropdownMenuItem<String>>[];
  var _selectedValue;
  var _todoDateController = TextEditingController();
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();

  _loadCategories() async {
    //instantiate category service
    var _categoryService = CategoryServices();
    var categoryItems = await _categoryService.readCategory();
    //loop through each category
    categoryItems.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category['name']),
          value: category['name'],
        ));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create A Todo Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //TODO set this formm fields in the center of the page
            //TODO check mythical designer video
            children: [
              TextField(
                controller: _todoTitleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter task title',
                ),
              ),
              TextField(
                controller: _todoDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter task description',
                ),
              ),
              TextField(
                controller: _todoDateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Pick a due date',
                  prefixIcon: InkWell(
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              DropdownButtonFormField(
                value: _selectedValue,
                hint: Text('Pick a category'),
                items: _categories,
                onChanged: (value) {
                  _selectedValue = value;
                },
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
