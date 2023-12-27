import 'package:master_interface_flutter/models/command_option.dart';
import 'package:master_interface_flutter/services/wifi_module_service.dart';
import 'package:master_interface_flutter/store/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class SetCommandOptionAction {
  final CommandOptionLabel command;

  SetCommandOptionAction({required this.command});
}

class SetPointAction {
  final double setPoint;

  SetPointAction(this.setPoint);
}

class SetKIAction {
  final double ki;

  SetKIAction(this.ki);
}

class SetKPAction {
  final double kp;

  SetKPAction(this.kp);
}

class SetKDAction {
  final double kd;

  SetKDAction(this.kd);
}

class SetDistanceLowerLimitAction {
  final double lowerLimit;

  SetDistanceLowerLimitAction(this.lowerLimit);
}

class SetDistanceUpperLimitAction {
  final double upperLimit;

  SetDistanceUpperLimitAction(this.upperLimit);
}

class SetDistanceValue {
  final double value;

  SetDistanceValue({required this.value});
}

class SetTemperatureLowerLimitAction {
  final double lowerLimit;

  SetTemperatureLowerLimitAction(this.lowerLimit);
}

class SetTemperatureUpperLimitAction {
  final double upperLimit;

  SetTemperatureUpperLimitAction(this.upperLimit);
}

class SetTemperatureValue {
  final double value;

  SetTemperatureValue({required this.value});
}

class SetConnectionStatusAction {
  final String? ip, port;
  final bool? isConnected;

  SetConnectionStatusAction({this.ip, this.port, this.isConnected});
}

ThunkAction<AppState> sendData() {
  return (Store<AppState> store) async {
    final command = store.state.command;
    final temperature = store.state.temperature;
    final distance = store.state.distance;

    final connection = store.state.connection;

    var commandData = command.command.label;
    switch (command.command) {
      case CommandOptionLabel.setPoint:
        commandData += "/${command.setPoint.toString()}";
        break;
      case CommandOptionLabel.kd:
        commandData += "/${command.kd.toString()}";
        break;
      case CommandOptionLabel.ki:
        commandData += "/${command.ki.toString()}";
        break;
      case CommandOptionLabel.kp:
        commandData += "/${command.kp.toString()}";
        break;
      default:
    }

    // format is 'command / command-value / temp-li / temp-ls / dist-li / dist-ls'
    final data =
        "$commandData/${temperature.lowerLimit}/${temperature.upperLimit}/${distance.lowerLimit}/${distance.upperLimit}";

    final service = await WifiConnectionService.getInstance();
    await service.sendData(
      ip: connection.ip!,
      port: int.parse(connection.port!),
      data: data,
    );
  };
}
