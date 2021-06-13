import 'package:flutter_redux_hooks/flutter_redux_hooks.dart';
import 'package:redux/redux.dart';
import '../../model/todo.dart';
import './todo_action.dart';
import '../app_state.dart';
import '../bottom_navigator/navigator_action.dart';

class TodoMiddleware extends MiddlewareClass<AppState> {
  @override
  void call(Store<AppState> store, action, next) {
    if (action is SetBottomNavigatorNumAction) {
      List<TodoContent> selectTodos =
          _selectTodos(action.navigation, store.state.todoState.todos);
      store.dispatch(SetSelectTodosAction(selectTodos));
    }
    if (action is RefreshSelectTodoAction) {
      List<TodoContent> selectTodos = _selectTodos(
          store.state.bottomNavigatorState.navigation,
          store.state.todoState.todos);
      store.dispatch(SetSelectTodosAction(selectTodos));
    }
    next(action);
  }

  List<TodoContent> _selectTodos(int selectNo, List<TodoContent> todos) {
    switch (selectNo) {
      case 0:
        return todos;
      case 1:
        return _toTodoContents(todos);
      case 2:
        return _doingTodoContents(todos);
      case 3:
        return _doneTodoContents(todos);
      default:
        return todos;
    }
  }

  List<TodoContent> _toTodoContents(List<TodoContent> todos) {
    return todos.where((todo) {
      return todo.isTo();
    }).toList();
  }

  List<TodoContent> _doingTodoContents(List<TodoContent> todos) {
    return todos.where((todo) {
      return todo.isDoing();
    }).toList();
  }

  List<TodoContent> _doneTodoContents(List<TodoContent> todos) {
    return todos.where((todo) {
      return todo.isDone();
    }).toList();
  }
}
