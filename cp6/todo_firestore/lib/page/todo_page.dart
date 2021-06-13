import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/todo.dart';
import '../provider/navigator.dart';
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
    final navigator = useProvider(bottomNavigatorNumProvider);
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
        currentIndex: navigator.state,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          navigator.state = index;
        },
      ),
    );
  }
}
