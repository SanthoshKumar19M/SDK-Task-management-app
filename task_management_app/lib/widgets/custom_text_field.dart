import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final Function(String)? onChanged;
  final String? initialValue;
  final bool enabled;

  CustomTextField({required this.label, this.onChanged, this.initialValue, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        onChanged: onChanged,
        enabled: enabled,
        controller: initialValue != null ? TextEditingController(text: initialValue) : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
