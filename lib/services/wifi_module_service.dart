import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';
import 'package:master_interface_flutter/models/connection_status.dart';
import 'package:udp/udp.dart';

final logger = Logger();

class WifiConnectionService {
  Future<void> connect({required Function(Datagram datagram) onRead}) async {
    final client = await UDP.bind(Endpoint.any(port: const Port(9000)));
    client.asStream().listen((event) {
      logger.d(event);
      if (event == null) {
        return;
      }

      onRead(event);
    });
  }

  static Future<void> sendData({
    required String ip,
    required int port,
    required String data,
  }) async {
    final client = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);
    client.send(data.codeUnits, InternetAddress(ip), port);
  }

  static Future<ConnectionStatus> pair() async {
    var sender = await UDP.bind(Endpoint.any(port: const Port(65000)));

    // send a simple string to a broadcast endpoint on port 65001.
    var dataLength = await sender.send(
        "Hello World!".codeUnits, Endpoint.broadcast(port: const Port(65001)));

    stdout.write("$dataLength bytes sent.");
    return ConnectionStatus(ip: null, port: null, isConnected: false);
  }
}
