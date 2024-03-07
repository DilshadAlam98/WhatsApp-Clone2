import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final String? Function(String? val)? validator;

  @override
  Widget build(BuildContext context) {
    final bordr = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.teal),
    );

    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: hintText,
        enabledBorder: bordr,
        border: bordr,
        focusedBorder: bordr,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
