import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_sqflite/model/todo.dart';
import 'package:todo_list_sqflite/services/category_services.dart';
import 'package:todo_list_sqflite/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  //global variables

  DateTime _todoDate = DateTime.now();

  List<DropdownMenuItem<String>> _categories = <DropdownMenuItem<String>>[];
  var _selectedValue;
  var _todoDateController = TextEditingController();
  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();

  void _selectTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _todoDate,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100));

    //null check
    if (_pickedDate != null) {
      setState(() {
        _todoDate = _pickedDate;
        _todoDateController.text = DateFormat('yMMMEd').format(_todoDate);
      });
    }
  }

  void _showSaveTodoToast() {
    FToast fToast = FToast();
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
          Text(
            'Created successfully',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

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
                    onTap: () {
                      _selectTodoDate(context);
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                ),
              ),
              DropdownButtonFormField(
                value: _selectedValue,
                hint: Text('Category'),
                items: _categories,
                onChanged: (value) {
                  _selectedValue = value;
                },
              ),
              SizedBox(height: 10),
              TextButton(
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                ),
                onPressed: () async {
                  var newTodo = Todo();
                  newTodo.title = _todoTitleController.text;
                  newTodo.description = _todoDescriptionController.text;
                  newTodo.category = _selectedValue.toString();
                  newTodo.todoDate = _todoDateController.text;
                  newTodo.isFinished = 0;

                  var todoService = TodoService();
                  var result = await todoService.saveTodo(newTodo);
                  print(result);
                  if (result > 0) {
                    _showSaveTodoToast();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
