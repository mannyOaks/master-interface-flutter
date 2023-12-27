import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:master_interface_flutter/hooks/redux.dart';

class ConnectionIndicator extends HookWidget {
  const ConnectionIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useSelector((state) => state.connection)!;

    void showConnectionStatusAlert() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Informacion de conexion"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BulletedList(listItems: [
                  Text.rich(
                    TextSpan(
                      text: "Direccion IP: ",
                      children: [
                        TextSpan(
                          text: state.ip,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Puerto: ",
                      children: [
                        TextSpan(
                          text: state.port,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ])
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Ok"),
              )
            ],
          );
        },
      );
    }

    return IconButton(
      onPressed: () {
        if (state.isConnected) {
          showConnectionStatusAlert();
        }
      },
      icon: Icon(
        Icons.circle,
        color: state.isConnected ? Colors.green : Colors.red,
      ),
      tooltip: !state.isConnected ? "Emparejando..." : "Conectado",
    );
  }
}
