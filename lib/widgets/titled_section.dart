import 'package:flutter/material.dart';
import 'package:master_interface_flutter/widgets/title_text.dart';

class TitledSection extends StatelessWidget {
  final String title;
  final bool showDivider;
  final Axis direction;
  final List<Widget> inputs;
  final void Function()? onInfoPressed;

  const TitledSection({
    required this.title,
    this.onInfoPressed,
    this.showDivider = true,
    this.direction = Axis.vertical,
    this.inputs = const [],
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final inputList = direction == Axis.horizontal
        ? Row(
            children: inputs.map((widget) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: widget,
              ),
            );
          }).toList())
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
                children: inputs.map((widget) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8), child: widget);
            }).toList()),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleText(title),
              if (onInfoPressed != null)
                IconButton(
                  icon: const Icon(Icons.info),
                  onPressed: onInfoPressed,
                )
            ],
          ),
        ),
        if (showDivider) const Divider(),
        if (!showDivider) const SizedBox(height: 8),
        inputList,
      ],
    );
  }
}
