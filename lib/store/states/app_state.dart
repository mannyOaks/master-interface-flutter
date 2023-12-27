import 'package:master_interface_flutter/store/states/command_state.dart';
import 'package:master_interface_flutter/store/states/connection_status_state.dart';
import 'package:master_interface_flutter/store/states/measurer_state.dart';

class AppState {
  final CommandState command;
  final MeasurerState temperature, distance;
  final ConnectionStatusState connection;

  const AppState({
    required this.command,
    required this.distance,
    required this.temperature,
    required this.connection,
  });

  static AppState initialState() => AppState(
        command: CommandState.initialState(),
        distance: MeasurerState.initialState(),
        temperature: MeasurerState.initialState(),
        connection: ConnectionStatusState.initialState(),
      );

  AppState copy({
    CommandState? command,
    MeasurerState? temperature,
    MeasurerState? distance,
    ConnectionStatusState? connection,
  }) {
    return AppState(
      command: command ?? this.command,
      distance: distance ?? this.distance,
      temperature: temperature ?? this.temperature,
      connection: connection ?? this.connection,
    );
  }
}
