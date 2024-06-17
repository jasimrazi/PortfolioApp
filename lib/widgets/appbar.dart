import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onLogout;

  const CustomAppBar({Key? key, required this.title, this.onLogout})
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
        if (onLogout != null)
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: onLogout,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
