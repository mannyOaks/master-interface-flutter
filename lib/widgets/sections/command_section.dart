import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:master_interface_flutter/hooks/redux.dart';
import 'package:master_interface_flutter/models/command_option.dart';
import 'package:master_interface_flutter/services/wifi_module_service.dart';
import 'package:master_interface_flutter/store/actions/actions.dart';
import 'package:master_interface_flutter/widgets/command_option_dropdown.dart';
import 'package:master_interface_flutter/widgets/titled_section.dart';

class CommandSection extends HookWidget {
  const CommandSection({super.key});

  @override
  Widget build(BuildContext context) {
    final command = useState(CommandOptionLabel.setPoint);
    final dispatch = useDispatch();
    final state = useSelector((state) => state.command)!;
    final connection = useSelector((state) => state.connection)!;
    final valueMap = {
      CommandOptionLabel.setPoint: state.setPoint,
      CommandOptionLabel.kd: state.kd,
      CommandOptionLabel.ki: state.ki,
      CommandOptionLabel.kp: state.kp,
    };

    final textFieldController = useTextEditingController(
      text: valueMap[CommandOptionLabel.setPoint].toString(),
    );

    void dispatcher(double value) {
      Object? action;
      switch (command.value) {
        case CommandOptionLabel.setPoint:
          action = SetPointAction(value);
          break;
        case CommandOptionLabel.kd:
          action = SetKDAction(value);
          break;
        case CommandOptionLabel.ki:
          action = SetKIAction(value);
          break;
        case CommandOptionLabel.kp:
          action = SetKPAction(value);
          break;
        default:
          action = null;
          break;
      }

      dispatch(action);
    }

    void submitHandler() async {
      if (!connection.isConnected) {
        return;
      }

      final udp = await WifiConnectionService.getInstance();

      // TODO: cambiar la forma en que se envia el comando
      udp.sendData(
        ip: connection.ip!,
        port: int.parse(connection.port!),
        data: "${command.value}/${textFieldController.text}",
      );
    }

    void openInfoDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Info"),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BulletedList(
                listItems: [
                  "Kp = Ganancia Proporcional",
                  "Ki = Ganancia Integral",
                  "Kd = Ganancia Derivativa",
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"),
            )
          ],
        ),
      );
    }

    return TitledSection(
      title: "Comandos",
      onInfoPressed: openInfoDialog,
      direction: Axis.horizontal,
      inputs: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              CommandOptionDropdown(
                onChange: (option) {
                  command.value = option;
                  textFieldController.text = valueMap[option].toString();
                },
              ),
              Expanded(
                child: TextField(
                  controller: textFieldController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => dispatcher(double.parse(value)),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 8),
                    border: InputBorder.none,
                    hintText: "Ingrese valor",
                  ),
                ),
              ),
              SizedBox(
                height: 72,
                child: ElevatedButton(
                  onPressed: () => connection.isConnected ? submitHandler : null,
                  child: const Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
