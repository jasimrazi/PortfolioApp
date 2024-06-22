import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onUserIconPressed;

  const CustomAppBar({Key? key, required this.title, this.onUserIconPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Color(0xfffafbfb),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        if (onUserIconPressed != null)
          IconButton(
            icon: Icon(Icons.person),
            onPressed: onUserIconPressed,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
