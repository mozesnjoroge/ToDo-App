// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/screens/categories_screen.dart';
import 'package:todo_list_sqflite/screens/home_screen.dart';
import 'package:todo_list_sqflite/services/category_services.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  //global variables
  List<Widget> _categoryList = <Widget>[];
  var _drawerCategoryService = CategoryServices();

  getAllCategories() async {
    var categories = await _drawerCategoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        _categoryList.add(ListTile(
          title: Text(category['name']),
        ));
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Moses Ngure'),
              accountEmail: Text('mozesdoe@mail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/appstore.png'),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Categories'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoriesScreen()));
              },
            ),
            Divider(
              thickness: 3.0,
              color: Colors.lightBlueAccent,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Column(
              children: _categoryList,
            )
          ],
        ),
      ),
    );
  }
}
