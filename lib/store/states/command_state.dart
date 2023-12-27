import 'package:master_interface_flutter/models/command_option.dart';

class CommandState {
  final double setPoint, kp, ki, kd;
  final CommandOptionLabel command;

  const CommandState({
    required this.setPoint,
    required this.kp,
    required this.ki,
    required this.kd,
    required this.command,
  });

  static CommandState initialState() => const CommandState(
        setPoint: 0,
        kp: 0,
        ki: 0,
        kd: 0,
        command: CommandOptionLabel.setPoint,
      );

  CommandState copy({
    double? setPoint,
    double? kp,
    double? ki,
    double? kd,
    CommandOptionLabel? command,
  }) {
    return CommandState(
      setPoint: setPoint ?? this.setPoint,
      kp: kp ?? this.kp,
      ki: ki ?? this.ki,
      kd: kd ?? this.kd,
      command: command ?? this.command,
    );
  }
}
