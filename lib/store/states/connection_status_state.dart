class ConnectionStatusState {
  final String? ip, port;
  final bool isConnected;

  const ConnectionStatusState({
    required this.ip,
    required this.port,
    required this.isConnected,
  });

  static ConnectionStatusState initialState() => const ConnectionStatusState(
        ip: null,
        port: null,
        isConnected: false,
      );

  ConnectionStatusState copy({String? ip, String? port, bool? isConnected}) {
    return ConnectionStatusState(
      ip: ip ?? this.ip,
      port: port ?? this.port,
      isConnected: isConnected ?? this.isConnected,
    );
  }
}
