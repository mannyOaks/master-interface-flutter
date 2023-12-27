import 'package:flutter/material.dart';
import 'package:master_interface_flutter/models/command_option.dart';

class CommandOptionDropdown extends StatelessWidget {
  final void Function(CommandOptionLabel option) onChange;

  const CommandOptionDropdown({required this.onChange, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: DropdownMenu<CommandOptionLabel>(
        initialSelection: CommandOptionLabel.setPoint,
        requestFocusOnTap: true,
        onSelected: (CommandOptionLabel? option) {
          if (option != null) {
            onChange(option);
          }
        },
        inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
        dropdownMenuEntries: CommandOptionLabel.values.map((option) {
          return DropdownMenuEntry<CommandOptionLabel>(
            value: option,
            label: "${option.code} - ${option.label}",
          );
        }).toList(),
      ),
    );
  }
}
