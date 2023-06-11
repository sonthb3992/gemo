import 'package:flutter/material.dart';

class InputFieldWidthValidator extends StatelessWidget {
  const InputFieldWidthValidator(
      {super.key,
      required this.controller,
      required this.label,
      required this.validator});

  final TextEditingController controller;
  final String? Function(String? value) validator;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        style: const TextStyle(fontSize: 18),
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: validator,
      ),
    );
  }
}
