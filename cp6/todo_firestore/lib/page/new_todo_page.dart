import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_firestore/model/todo.dart';
import 'package:todo_firestore/provider/todos.dart';

import '../model/todo.dart';

class NewTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _titleController = TextEditingController();
    final _contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("新規登録"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 0, right: 30, bottom: 0, left: 30),
                child: TextField(
                  obscureText: false,
                  maxLines: 1,
                  controller: _titleController,
                  decoration:
                      InputDecoration(labelText: "タイトル", hintText: "買い物"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, right: 30, bottom: 0, left: 30),
                child: TextField(
                  obscureText: false,
                  maxLines: 8,
                  controller: _contentController,
                  decoration:
                      InputDecoration(labelText: "内容", hintText: "りんごを買う"),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (!_titleController.text.isEmpty &&
                      !_contentController.text.isEmpty) {
                    final uuid = Uuid();
                    await FirebaseFirestore.instance
                        .collection("todos")
                        .doc(uuid.v4())
                        .set({
                      'title': _titleController.text,
                      'content': _contentController.text,
                      'state': TodoStatus.to.index
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text("登録"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
