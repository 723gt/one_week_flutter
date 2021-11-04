// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:widget_test_app/main.dart';
import 'package:widget_test_app/provider/todos.dart';
import 'package:widget_test_app/model/todo.dart';

void main() {
  group("画面表示", () {
    group("BottomNavigator", () {
      testWidgets("Allのボタンが表示されること", (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(child: MyApp()));
        expect(find.byIcon(Icons.list), findsOneWidget);
      });
      testWidgets("Toのボタンが表示されること", (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(child: MyApp()));
        expect(find.byIcon(Icons.push_pin), findsOneWidget);
      });
      testWidgets("Doingのボタンが表示されること", (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(child: MyApp()));
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      });
      testWidgets("Doneのボタンが表示されること", (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(child: MyApp()));
        expect(find.byIcon(Icons.check), findsOneWidget);
      });
    });
  });

  group("Todoの表示切り替え", () {
    final List<TodoContent> testTodos = [
      TodoContent(title: "to", content: "test", state: TodoStatus.to),
      TodoContent(title: "doing", content: "test", state: TodoStatus.doing),
      TodoContent(title: "done", content: "test", state: TodoStatus.done),
    ];
    testWidgets("AllですべてのTodoが表示されること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MyApp(),
        overrides: [todosProvider.overrideWithValue(Todos(testTodos))],
      ));

      await tester.pumpAndSettle();
      expect(find.text("to(To)"), findsOneWidget);
      expect(find.text("doing(Doing)"), findsOneWidget);
      expect(find.text("done(Done)"), findsOneWidget);
    });
    testWidgets("ToのTodoのみが表示されること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MyApp(),
        overrides: [todosProvider.overrideWithValue(Todos(testTodos))],
      ));
      await tester.tap(find.byIcon(Icons.push_pin));
      await tester.pumpAndSettle();
      expect(find.text("to(To)"), findsOneWidget);
      expect(find.text("doing(Doing)"), findsNothing);
      expect(find.text("done(Done)"), findsNothing);
    });
    testWidgets("DoingのTodoのみが表示されること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MyApp(),
        overrides: [todosProvider.overrideWithValue(Todos(testTodos))],
      ));
      await tester.tap(find.byIcon(Icons.play_arrow));
      await tester.pumpAndSettle();
      expect(find.text("to(To)"), findsNothing);
      expect(find.text("doing(Doing)"), findsOneWidget);
      expect(find.text("done(Done)"), findsNothing);
    });
    testWidgets("DoneのTodoのみが表示されること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MyApp(),
        overrides: [todosProvider.overrideWithValue(Todos(testTodos))],
      ));
      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();
      expect(find.text("to(To)"), findsNothing);
      expect(find.text("doing(Doing)"), findsNothing);
      expect(find.text("done(Done)"), findsOneWidget);
    });
  });

  group("todoの作成", () {
    testWidgets("新規作成画面に移動すること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(child: MyApp()));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text("新規登録"), findsOneWidget);
    });

    testWidgets("空の場合は画面遷移しないこと", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(child: MyApp()));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.tap(find.text("登録"));
      await tester.pumpAndSettle();
      expect(find.text("新規登録"), findsOneWidget);
    });
    testWidgets("タイトルだけ入力された場合は画面遷移しないこと", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(child: MyApp()));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, "タイトル"), "title");
      await tester.tap(find.text("登録"));
      await tester.pumpAndSettle();
      expect(find.text("新規登録"), findsOneWidget);
    });
    testWidgets("内容だけ入力された場合は画面遷移しないこと", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(child: MyApp()));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(find.widgetWithText(TextField, "内容"), "content");
      await tester.tap(find.text("登録"));
      await tester.pumpAndSettle();
      expect(find.text("新規登録"), findsOneWidget);
    });
    testWidgets("登録が成功して画面遷移すること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(child: MyApp()));
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.enterText(
          find.widgetWithText(TextField, "タイトル"), "testTodo");
      await tester.enterText(find.widgetWithText(TextField, "内容"), "content");
      await tester.tap(find.text("登録"));
      await tester.pumpAndSettle();
      expect(find.text("testTodo(To)"), findsOneWidget);
      expect(find.text("WidgetTestApp"), findsOneWidget);
    });
  });

  group("Todoの更新", () {
    final List<TodoContent> testTodos = [
      TodoContent(title: "Dummy", content: "test", state: TodoStatus.to),
    ];
    testWidgets("Todo詳細画面に遷移すること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MyApp(),
        overrides: [todosProvider.overrideWithValue(Todos(testTodos))],
      ));
      await tester.tap(find.text("Dummy(To)"));
      await tester.pumpAndSettle();
      expect(find.text("タイトル: Dummy"), findsOneWidget);
      expect(find.text("状態: To"), findsOneWidget);
      expect(find.text("状態を更新"), findsOneWidget);
    });
    testWidgets("Todoの状態が更新されること", (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MyApp(),
        overrides: [todosProvider.overrideWithValue(Todos(testTodos))],
      ));
      await tester.tap(find.text("Dummy(To)"));
      await tester.pumpAndSettle();
      await tester.tap(find.text("状態を更新"));
      await tester.pump();
      expect(find.text("状態: To"), findsNothing);
      expect(find.text("状態: Doing"), findsOneWidget);
    });
  });
}
