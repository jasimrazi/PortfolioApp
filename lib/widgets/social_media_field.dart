import 'package:flutter/material.dart';
import 'package:portfolioapp/widgets/textfield.dart';

class SocialMediaField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onRemove;

  SocialMediaField({
    required this.controller,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: buildTextField(
            controller: controller,
            labelText: 'Social Media URL',
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
          onPressed: onRemove,
        ),
      ],
    );
  }
}
