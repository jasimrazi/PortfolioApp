import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData? icon;

  const CustomTextButton({
    required this.text,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            icon,
            color: Colors.lightGreen,
            size: 20,
          )
        ],
      ),
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey.shade200; // Change to your desired color
            }
            return Colors.transparent; // Use transparent for default behavior
          },
        ),
      ),
    );
  }
}
