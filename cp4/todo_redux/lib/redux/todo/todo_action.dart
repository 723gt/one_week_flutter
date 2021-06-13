import '../../model/todo.dart';

class AddTodoAction {
  final String title;
  final String content;

  AddTodoAction({this.title, this.content});
}

class SetSelectTodosAction {
  final List<TodoContent> selectTodos;
  SetSelectTodosAction(this.selectTodos);
}

class RefreshSelectTodoAction {}
