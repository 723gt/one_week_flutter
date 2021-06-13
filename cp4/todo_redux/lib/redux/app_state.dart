import 'package:flutter/material.dart';
import './todo/todo_state.dart';
import './bottom_navigator/navigator_state.dart';

@immutable
class AppState {
  final TodoState todoState;
  final BottomNavigatorState bottomNavigatorState;
  AppState({@required this.todoState, @required this.bottomNavigatorState});

  factory AppState.initial() => AppState(
      todoState: TodoState.initial(),
      bottomNavigatorState: BottomNavigatorState.initial());

  AppState copyWith(
      {TodoState todoState, BottomNavigatorState bottomNavigatorState}) {
    return AppState(
        todoState: todoState ?? this.todoState,
        bottomNavigatorState:
            bottomNavigatorState ?? this.bottomNavigatorState);
  }
}
