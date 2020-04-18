import 'package:todoapp/models/todo.dart';
import 'package:todoapp/repo/repository.dart';

class TodoService {
  Repository _repository;

  TodoService () {
    _repository = Repository();
  }

  insertTodo(Todo todo) async {
   return await _repository.save('todos', todo.todoMap());
  }

  getTodos() async {
    return await _repository.getAll('todos');
  }
}