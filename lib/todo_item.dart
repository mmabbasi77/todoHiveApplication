import 'package:hive_flutter/hive_flutter.dart';
part 'todo_item.g.dart';

@HiveType(typeId: 1)
class TodoItem {
  @HiveField(0)
  final String title;
  @HiveField(1, defaultValue: false)
  bool isComplete;
  TodoItem(this.title, this.isComplete);
}
