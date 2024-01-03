import 'dart:io';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logger/logger.dart';
import 'package:master_interface_flutter/hooks/redux.dart';
import 'package:master_interface_flutter/store/actions/actions.dart';
import 'package:udp/udp.dart';

import 'views/home_screen.dart';

class UDPApplication extends HookWidget {
  UDPApplication({super.key});

  final logger = Logger();

  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch();

    void connectToArduino() async {
      try {
        final multicastEndpoint = Endpoint.multicast(
          InternetAddress("127.0.0.1"),
          port: const Port(9000),
        );

        final receiver = await UDP.bind(multicastEndpoint);
        final sender = await UDP.bind(Endpoint.any(port: const Port(9000)));

        receiver.asStream().listen((datagram) {
          logger.d(datagram);
          if (datagram != null) {
            var str = String.fromCharCodes(datagram.data);
            logger.d(str);

            stdout.write(str);
          }
        });

        await sender.send("25".codeUnits, multicastEndpoint);

        await Future.delayed(const Duration(seconds: 5));

        sender.close();
        receiver.close();
      } catch (e) {
        logger.e("Error", error: e);
        dispatch(
          SetConnectionStatusAction(
            ip: null,
            port: null,
            isConnected: false,
          ),
        );
        connectToArduino();
      }
    }

    useEffect(() {
      connectToArduino();
      return null;
    }, []);

    return MaterialApp(
      title: 'Microcontroladores',
      theme: FlexThemeData.dark(
        scheme: FlexScheme.deepPurple,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
