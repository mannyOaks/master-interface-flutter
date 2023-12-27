class ConnectionStatus {
  final String? ip, port;
  final bool? isConnected;

  ConnectionStatus({
    required this.ip,
    required this.port,
    required this.isConnected,
  });
}
