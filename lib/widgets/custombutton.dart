import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final String text;
  final VoidCallback? onTap;

  const CustomButton({
    Key? key,
    required this.isLoading,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        decoration: BoxDecoration(
          color: Colors.black, // Set your desired color here
          borderRadius: BorderRadius.circular(15),
        ),
        child: isLoading
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CupertinoActivityIndicator(),
                  SizedBox(width: 10),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
      ),
    );
  }
}
