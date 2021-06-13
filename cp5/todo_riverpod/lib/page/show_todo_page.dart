import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/todo.dart';
import '../provider/todos.dart';

class ShowTodoPage extends StatefulWidget {
  final TodoContent todo;
  ShowTodoPage({Key key, this.todo});
  @override
  _ShowTodoState createState() => _ShowTodoState();
}

class _ShowTodoState extends State<ShowTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.todo.title),
        ),
        body: Container(
            child: Center(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("タイトル: ${widget.todo.title}"),
            Text("内容"),
            Text(widget.todo.content),
            Text("状態: ${widget.todo.getStateString()}"),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.todo.setNextState();
                  });
                  context.read(todosProvider.notifier).update();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("状態を更新しました")));
                },
                child: Text("状態を更新"))
          ],
        ))));
  }
}
