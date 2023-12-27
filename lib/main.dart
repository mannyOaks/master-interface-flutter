import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:logger/logger.dart';
import 'package:master_interface_flutter/hooks/redux.dart';
import 'package:master_interface_flutter/services/wifi_module_service.dart';
import 'package:master_interface_flutter/store/actions/actions.dart';
import 'package:master_interface_flutter/store/states/app_state.dart';

import 'store/store.dart';
import 'views/home_screen.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: HookBuilder(
        builder: (context) {
          final dispatch = useDispatch();

          void connectToArduino() async {
            try {
              final service = await WifiConnectionService.getInstance();
              // set connection status for display
              dispatch(
                SetConnectionStatusAction(
                  ip: service.udp.socket?.address.host,
                  port: service.udp.socket?.port.toString(),
                  isConnected: service.udp.socket != null,
                ),
              );

              // read data
              service.udp.asStream().listen((event) {
                if (event != null) {
                  final data = String.fromCharCodes(event.data).split("/");

                  final temperatureValue = double.parse(data[1]);
                  final distanceValue = double.parse(data[5]);

                  dispatch(SetDistanceValue(value: distanceValue));
                  dispatch(SetTemperatureValue(value: temperatureValue));
                }
              });
            } catch (e) {
              Logger().e("Error", error: e);
            }
          }

          useEffect(() {
            Future(connectToArduino);
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
        },
      ),
    );
  }
}
