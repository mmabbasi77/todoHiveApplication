import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todo_service.dart';

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  final TodoService _todoService = TodoService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Todo List"),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.green,
        child: Text(
          "+",
          style: TextStyle(color: Colors.white, fontSize: size.height / 25),
        ),
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add todo"),
                  content: TextField(
                    controller: _controller,
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text("add"),
                      onPressed: () async {
                        var todo = TodoItem(_controller.text, false);
                        await _todoService.addItem(todo);
                        _controller.text = "";
                        Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<TodoItem>('todoBox').listenable(),
        builder: (context, Box<TodoItem> box, _) {
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              var todo = box.getAt(index);
              return ListTile(
                title: Text(todo!.title),
                leading: Checkbox(
                  value: todo.isComplete,
                  onChanged: (val) {
                    _todoService.updateIsComplete(index, todo);
                  },
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _todoService.deleteTodo(index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
