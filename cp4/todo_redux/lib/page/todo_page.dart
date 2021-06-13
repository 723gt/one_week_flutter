import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import 'package:flutter_redux_hooks/flutter_redux_hooks.dart';
import 'package:todo_redux/redux/bottom_navigator/navigator_action.dart';
import '../redux/bottom_navigator/navigator_action.dart';
import '../redux/app_state.dart';
import '../model/todo.dart';
import './todo_list_page.dart';
import './new_todo_page.dart';

class TodoPage extends HookWidget {
  final String title;
  TodoPage({Key key, this.title}) : super(key: key);

  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.list,
      ),
      label: 'All',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.push_pin,
      ),
      label: 'To',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.play_arrow,
      ),
      label: 'Doing',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.check,
      ),
      label: 'Done',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final navigator = useSelector<AppState, int>(
        (state) => state.bottomNavigatorState.navigation);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: TodoListPage(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewTodoPage()));
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        fixedColor: Colors.blueAccent,
        currentIndex: navigator,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          store.dispatch(SetBottomNavigatorNumAction(index));
        },
      ),
    );
  }
}
