import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Color(0xfffafbfb),
      iconTheme: IconThemeData(color: Colors.black),
      // Customize other properties of the AppBar as needed
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
