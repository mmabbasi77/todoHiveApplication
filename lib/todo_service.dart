import 'package:hive/hive.dart';
import 'package:todo_app/todo_item.dart';

class TodoService {
  final String _boxName = "todoBox";

  Future<Box<TodoItem>> get _box async =>
      await Hive.openBox<TodoItem>(_boxName);

  Future<void> addItem(TodoItem todoItem) async {
    var box = await _box;
    await box.add(todoItem);
  }

  Future<List<TodoItem>> getAllTodos() async {
    var box = await _box;
    return box.values.toList();
  }

  Future<void> deleteTodo(int index) async {
    var box = await _box;
    await box.deleteAt(index);
  }

  Future<void> updateIsComplete(int index, TodoItem todoItem) async {
    var box = await _box;
    todoItem.isComplete = !todoItem.isComplete;
    await box.putAt(index, todoItem);
  }
}
