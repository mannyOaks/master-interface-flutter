import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FloatInput extends HookWidget {
  final String? label;
  final double? value;
  final void Function(String value)? onChanged;

  const FloatInput({this.label, this.value, this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    Text? labelWidget = label != null ? Text(label!) : null;
    final controller = useTextEditingController(text: value?.toString());

    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        label: labelWidget,
        border: const OutlineInputBorder(),
        hintText: label,
      ),
    );
  }
}
