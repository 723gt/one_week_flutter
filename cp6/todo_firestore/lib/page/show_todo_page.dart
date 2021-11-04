import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/todo.dart';
import '../provider/todos.dart';

class ShowTodoPage extends StatefulWidget {
  final TodoContent todo;
  ShowTodoPage({Key? key, required this.todo});
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
                onPressed: () async {
                  setState(() {
                    widget.todo.setNextState();
                  });
                  await FirebaseFirestore.instance
                      .collection("todos")
                      .doc(widget.todo.id)
                      .update({'state': widget.todo.getTodoIndex()});
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("状態を更新しました")));
                },
                child: Text("状態を更新")),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("todos")
                    .doc(widget.todo.id)
                    .delete();
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("状態を更新しました")));
                Navigator.pop(context);
              },
              child: Text("削除"),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
            )
          ],
        ))));
  }
}
