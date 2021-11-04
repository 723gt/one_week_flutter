import 'package:flutter/material.dart';
import './show_todo_page.dart';
import '../model/todo.dart';

class TodoListPage extends StatelessWidget {
  final List<TodoContent> todos;
  TodoListPage({required this.todos});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShowTodoPage(
                                    todo: todos[index],
                                  )));
                    },
                    child: ListTile(
                      title: Text(
                          "${todos[index].title}(${todos[index].getStateString()})"),
                      subtitle: Text(todos[index].content),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
