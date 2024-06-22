import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String labelText,
  int maxLines = 1,
  Widget? suffixIcon,
  VoidCallback? onPressed,
  bool isObscure = false, // Added the isObscure parameter here
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: TextField(
      cursorColor: Colors.grey,
      controller: controller,
      maxLines: maxLines,
      obscureText: isObscure, // Used isObscure here
      decoration: InputDecoration(
        hintText: labelText,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      ),
      onTap: onPressed,
    ),
  );
}
