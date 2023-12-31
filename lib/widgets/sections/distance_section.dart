import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:master_interface_flutter/hooks/redux.dart';
import 'package:master_interface_flutter/store/actions/actions.dart';
import 'package:master_interface_flutter/widgets/input.dart';
import 'package:master_interface_flutter/widgets/titled_section.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DistanceSection extends HookWidget {
  const DistanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = useSelector((state) => state.distance)!;
    final dispatch = useDispatch();

    void sendDistanceData() async {
      dispatch(sendApplicationData());
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TitledSection(
            title: "Limites de Distancia",
            showDivider: false,
            inputs: [
              FloatInput(
                label: "Superior",
                value: state.upperLimit,
                onChanged: (value) {
                  dispatch(SetDistanceLowerLimitAction(double.parse(value)));
                },
              ),
              FloatInput(
                label: "Inferior",
                value: state.lowerLimit,
                onChanged: (value) {
                  dispatch(SetDistanceUpperLimitAction(double.parse(value)));
                },
              ),
              ElevatedButton.icon(
                onPressed: sendDistanceData,
                icon: const Icon(Icons.send),
                label: const Text("Enviar"),
              ),
            ],
          ),
        ),
        SfLinearGauge(
          orientation: LinearGaugeOrientation.vertical,
          interval: 10,
          maximum: 100,
          minorTicksPerInterval: 1,
          ranges: [
            LinearGaugeRange(
              startValue: 0,
              endValue: state.value,
              color: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}
