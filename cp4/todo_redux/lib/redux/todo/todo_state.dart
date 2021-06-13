import 'package:flutter/material.dart';
import '../../model/todo.dart';
import '../../model/todo.dart';

@immutable
class TodoState {
  final List<TodoContent> todos;
  final List<TodoContent> selectTodos;
  TodoState({@required this.todos, this.selectTodos});
  factory TodoState.initial() => TodoState(todos: [
        TodoContent(
            title: "Todo01", content: "Todo Content01", c: TodoStatus.to),
        TodoContent(
            title: "Todo02", content: "Todo Content02", c: TodoStatus.to),
        TodoContent(
            title: "Todo03", content: "Todo Content03", c: TodoStatus.doing),
        TodoContent(
            title: "Todo04", content: "Todo Content04", c: TodoStatus.doing),
        TodoContent(
            title: "Todo05", content: "Todo Content05", c: TodoStatus.done),
      ], selectTodos: []);

  TodoState copyWith({List<TodoContent> todos, List<TodoContent> selectTodos}) {
    return TodoState(
        todos: todos ?? this.todos,
        selectTodos: selectTodos ?? this.selectTodos);
  }
}
