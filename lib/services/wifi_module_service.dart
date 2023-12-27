import 'dart:async';
import 'dart:io';

import 'package:udp/udp.dart';

class WifiConnectionService {
  late UDP udp;

  static WifiConnectionService? _instance;

  static Future<WifiConnectionService> getInstance([int port = 9000]) async {
    if (_instance == null) {
      final client = await UDP.bind(Endpoint.any(port: Port(port)));
      _instance = WifiConnectionService._private(client);
    }

    return _instance!;
  }

  WifiConnectionService._private(UDP client) {
    udp = client;
  }

  Future<void> sendData({
    required String ip,
    required int port,
    required String data,
  }) async {
    udp.send(
      data.codeUnits,
      Endpoint.unicast(
        InternetAddress(ip),
        port: Port(port),
      ),
    );
  }
}
