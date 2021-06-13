import 'package:flutter/material.dart';
import 'package:flutter_redux_hooks/flutter_redux_hooks.dart';
import 'package:redux/redux.dart';
import './page/todo_page.dart';
import './redux/store.dart';
import './redux/app_state.dart';

void main() async {
  final Store<AppState> store = await createStore();
  runApp(MyApp(
    store: store,
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TodoPage(
          title: "Todo App",
        ),
      ),
    );
  }
}
