import 'package:redux/redux.dart';
import './navigator_action.dart';
import './navigator_state.dart';

final bottomNavigatorReducer = combineReducers<BottomNavigatorState>([
  TypedReducer<BottomNavigatorState, SetBottomNavigatorNumAction>(
      _setBottomNavigatorNum),
]);

BottomNavigatorState _setBottomNavigatorNum(
    BottomNavigatorState state, SetBottomNavigatorNumAction action) {
  return BottomNavigatorState(navigation: action.navigation);
}
