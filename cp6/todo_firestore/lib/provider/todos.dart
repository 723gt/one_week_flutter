import 'dart:js';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/todo.dart';
import '../model/todo.dart';
import '../model/todo.dart';
import '../model/todo.dart';
import '../model/todo.dart';
import '../model/todo.dart';
import '../model/todo.dart';
import './navigator.dart';

final selectTodosProvider = Provider.autoDispose((ref) async {
  final navigator = ref.watch(bottomNavigatorNumProvider);
  final futuretodosList = ref.watch(todoStreamProvider.last);
  List<TodoContent> todos = await futuretodosList;

  switch (navigator.state) {
    case 0:
      return todos;
    case 1:
      return todos.where((todo) {
        return todo.isTo();
      }).toList();

    case 2:
      return todos.where((todo) {
        return todo.isDoing();
      }).toList();

    case 3:
      return todos.where((todo) {
        return todo.isDone();
      }).toList();

    default:
      return todos;
  }
});

final todoStreamProvider = StreamProvider.autoDispose<List<TodoContent>>((_) {
  final snapshots = FirebaseFirestore.instance.collection("todos").snapshots();
  final snapshotList = snapshots.map((snapshot) => snapshot.docs
      .map((e) => TodoContent(
          id: e.id,
          title: e.data()['title'],
          content: e.data()['content'],
          stateNum: e.data()['state']))
      .toList());
  return snapshotList;
});
