import 'package:master_interface_flutter/store/actions/actions.dart';
import 'package:master_interface_flutter/store/states/command_state.dart';
import 'package:master_interface_flutter/store/states/connection_status_state.dart';
import 'package:master_interface_flutter/store/states/measurer_state.dart';

MeasurerState temperatureReducer(MeasurerState state, dynamic action) {
  if (action is SetTemperatureLowerLimitAction) {
    return state.copy(lowerLimit: action.lowerLimit);
  } else if (action is SetTemperatureUpperLimitAction) {
    return state.copy(upperLimit: action.upperLimit);
  }

  return state;
}

MeasurerState distanceReducer(MeasurerState state, dynamic action) {
  if (action is SetDistanceLowerLimitAction) {
    return state.copy(lowerLimit: action.lowerLimit);
  } else if (action is SetDistanceUpperLimitAction) {
    return state.copy(upperLimit: action.upperLimit);
  }

  return state;
}

CommandState commandReducer(CommandState state, dynamic action) {
  if (action is SetPointAction) {
    return state.copy(setPoint: action.setPoint);
  } else if (action is SetKPAction) {
    return state.copy(kp: action.kp);
  } else if (action is SetKIAction) {
    return state.copy(ki: action.ki);
  } else if (action is SetKDAction) {
    return state.copy(kd: action.kd);
  } else if (action is SetCommandOptionAction) {
    return state.copy(command: action.command);
  }

  return state;
}

ConnectionStatusState connectionStatusReducer(
  ConnectionStatusState state,
  dynamic action,
) {
  if (action is SetConnectionStatusAction) {
    return state.copy(
      ip: action.ip,
      port: action.port,
      isConnected: action.isConnected,
    );
  }

  return state;
}
