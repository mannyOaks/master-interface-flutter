import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:master_interface_flutter/app.dart';
import 'package:master_interface_flutter/store/states/app_state.dart';

import 'store/store.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: UDPApplication(),
    );
  }
}
