import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:master_interface_flutter/widgets/connection_indicator.dart';
import 'package:master_interface_flutter/widgets/sections/command_section.dart';
import 'package:master_interface_flutter/widgets/sections/distance_section.dart';
import 'package:master_interface_flutter/widgets/sections/temperature_section.dart';
import 'package:master_interface_flutter/widgets/title_text.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Microcontroladores"),
        actions: const [ConnectionIndicator()],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(getValueForScreenType(
          context: context,
          mobile: 12,
          desktop: 24,
        )),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16, bottom: 8, left: 6),
              child: TitleText("Variables de control"),
            ),
            const Divider(),
            ScreenTypeLayout.builder(
              breakpoints: const ScreenBreakpoints(
                tablet: 600,
                desktop: 720,
                watch: 300,
              ),
              mobile: (context) => const Column(
                children: [
                  TemperatureSection(),
                  DistanceSection(),
                ],
              ),
              desktop: (context) => const Row(
                children: [
                  Expanded(child: TemperatureSection()),
                  SizedBox(width: 32),
                  Expanded(child: DistanceSection()),
                ],
              ),
            ),
            const CommandSection(),
          ],
        ),
      ),
    );
  }
}
