import 'package:todoapp/models/category.dart';
import 'package:todoapp/repo/repository.dart';

class CategoryService{

  Repository _repository;

  CategoryService () {
    _repository = Repository();
  }

  saveCategory(Category category) async {
    return await _repository.save('categories', category.categoryMap());
  }

  getCategories() async {
    return await _repository.getAll('categories');
  }
}