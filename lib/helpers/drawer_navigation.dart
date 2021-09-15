// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:todo_list_sqflite/screens/categories_screen.dart';
import 'package:todo_list_sqflite/screens/home_screen.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CategoriesScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
