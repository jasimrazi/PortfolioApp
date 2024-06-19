import 'package:flutter/material.dart';

Widget buildNormalTextField({
  required TextEditingController controller,
  required String hintText,
  bool obscureText = false,
  int maxLines = 1,
  Widget? suffixIcon,
  VoidCallback? onPressed,
  String? errorText,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (errorText != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            errorText,
            style: TextStyle(color: Colors.red, fontSize: 12.0),
          ),
        ),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: errorText != null ? Colors.red : Colors.grey.shade200,
          ),
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ),
          onTap: onPressed,
        ),
      ),
    ],
  );
}
