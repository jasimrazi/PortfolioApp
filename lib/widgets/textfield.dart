import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  bool obscureText = false,
  int maxLines = 1,
  Widget? suffixIcon,
}) {
  return TextField(
    controller: controller,
    obscureText: obscureText,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: labelText,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(),
    ),
  );
}
