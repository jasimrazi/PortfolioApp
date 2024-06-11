import 'package:flutter/material.dart';

Widget buildNormalTextField({
  required TextEditingController controller,
  required String hintText,
  bool obscureText = false,
  int maxLines = 1,
  Widget? suffixIcon,
  VoidCallback? onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.0),
      border: Border.all(color: Colors.grey),
    ),
    child: TextField(
      cursorColor: Colors.grey,
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      ),
      onTap: onPressed,
    ),
  );
}
