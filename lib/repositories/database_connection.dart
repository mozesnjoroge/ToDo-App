import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseConnection {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var dbPath = join(directory.path, 'db_todolist_sqflite');
    var database =
        openDatabase(dbPath, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database.execute(
        'CREATE TABLE Categories(id INTEGER PRIMARY KEY, name TEXT, description TEXT)');

    //new table todo
    await database.execute(
        'CREATE TABLE Todos(id INTEGER PRIMARY KEY, title TEXT, description TEXT, category TEXT, todoDate EXT, isFinished INTEGER )');
  }
}
