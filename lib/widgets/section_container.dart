import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final IconData? icon; // New optional parameter for the icon

  const SectionContainer({
    Key? key,
    required this.title,
    required this.child,
    this.icon, // Initialize the icon parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) // Conditionally add the icon if it's provided
                Icon(
                  icon,
                  color: Colors
                      .grey.shade500, // Customize the icon color as needed
                ),
              if (icon != null)
                SizedBox(width: 10), // Add spacing between icon and title
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
