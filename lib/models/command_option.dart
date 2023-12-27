enum CommandOptionLabel {
  setPoint(code: 31, label: 'SetPoint'),
  kp(code: 32, label: 'Kp'),
  ki(code: 33, label: 'Ki'),
  kd(code: 34, label: 'Kd');

  final String label;
  final int code;

  const CommandOptionLabel({required this.code, required this.label});
}
