import 'package:flutter/material.dart';

@immutable
class BottomNavigatorState {
  final int navigation;

  BottomNavigatorState({this.navigation});

  factory BottomNavigatorState.initial() => BottomNavigatorState(navigation: 0);

  BottomNavigatorState copyWith(int navigation) {
    return BottomNavigatorState(navigation: navigation ?? this.navigation);
  }
}
