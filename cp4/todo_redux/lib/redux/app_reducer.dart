import './app_state.dart';
import './todo/todo_reducer.dart';
import './bottom_navigator/navigator_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
      todoState: todoReducer(state.todoState, action),
      bottomNavigatorState:
          bottomNavigatorReducer(state.bottomNavigatorState, action));
}
