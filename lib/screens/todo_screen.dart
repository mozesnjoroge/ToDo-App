import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/model/category.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _categories;

  var _todoTitleController = TextEditingController();
  var _todoDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var _selectedValue;
    var _todoDateController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create A Todo Task'),
      ),
      body: Padding(
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
                value = _selectedValue;
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Save'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
