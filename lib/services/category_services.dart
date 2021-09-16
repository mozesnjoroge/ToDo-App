import 'package:todo_list_sqflite/model/category.dart';
import 'package:todo_list_sqflite/repositories/repository.dart';

class CategoryServices {
  Repository? _repository;

  CategoryServices() {
    //initialize the repository
    _repository = Repository();
  }
  insertCategory(Category newCategory) async {
    return await _repository!
        .insertData('Categories', newCategory.categoryMap());
  }

  readCategory() {
    return _repository!.readData('Categories');
  }
}
