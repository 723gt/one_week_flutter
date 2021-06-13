import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import '../model/todo.dart';
import './navigator.dart';

class Todos extends StateNotifier<List<TodoContent>> {
  Todos(List<TodoContent> initTodos) : super(initTodos ?? []);

  void add({String title, String content}) {
    state = [
      ...state,
      TodoContent(title: title, content: content),
    ];
  }

  void update() {
    state = state;
  }
}

final todosProvider = StateNotifierProvider<Todos, List<TodoContent>>((ref) =>
    Todos([
      TodoContent(title: "Todo01", content: "Todo Content01", c: TodoStatus.to),
      TodoContent(title: "Todo02", content: "Todo Content02", c: TodoStatus.to),
      TodoContent(
          title: "Todo03", content: "Todo Content03", c: TodoStatus.doing),
      TodoContent(
          title: "Todo04", content: "Todo Content04", c: TodoStatus.doing),
      TodoContent(
          title: "Todo05", content: "Todo Content05", c: TodoStatus.done),
    ]));

final selectTodosProvider = Provider<List<TodoContent>>((ref) {
  final navigator = ref.watch(bottomNavigatorNumProvider);
  final todos = ref.watch(todosProvider);

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
