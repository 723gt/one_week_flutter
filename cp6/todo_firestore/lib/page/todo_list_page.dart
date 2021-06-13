import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget, useFuture;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../provider/todos.dart';
import './show_todo_page.dart';
import '../model/todo.dart';

class TodoListPage extends HookWidget {
  TodoListPage();
  @override
  Widget build(BuildContext context) {
    final futureTodoProvider = useProvider(selectTodosProvider);
    final snapshot = useFuture(futureTodoProvider);
    List<TodoContent> todos = [];
    if (snapshot.hasData) {
      todos = snapshot.data;
    }
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
