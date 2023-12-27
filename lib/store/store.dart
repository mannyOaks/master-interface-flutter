import 'package:master_interface_flutter/store/reducers/reducers.dart';
import 'package:master_interface_flutter/store/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

AppState reducer(AppState state, dynamic action) => AppState(
      command: commandReducer(state.command, action),
      distance: distanceReducer(state.distance, action),
      temperature: temperatureReducer(state.temperature, action),
      connection: connectionStatusReducer(state.connection, action),
    );

final store = Store<AppState>(
  reducer,
  initialState: AppState.initialState(),
  middleware: [thunkMiddleware],
);
