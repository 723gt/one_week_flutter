import 'package:redux/redux.dart';
import '../../model/todo.dart';
import '../../model/todo.dart';
import './todo_action.dart';
import './todo_state.dart';

final todoReducer = combineReducers<TodoState>([
  TypedReducer<TodoState, AddTodoAction>(_addTodoActionReducer),
  TypedReducer<TodoState, SetSelectTodosAction>(_setSelectTodos),
]);

TodoState _addTodoActionReducer(TodoState state, AddTodoAction action) {
  List<TodoContent> todos = state.todos;
  todos.add(TodoContent(title: action.title, content: action.content));
  return state.copyWith(todos: todos);
}

TodoState _setSelectTodos(TodoState state, SetSelectTodosAction action) {
  return state.copyWith(selectTodos: action.selectTodos);
}
