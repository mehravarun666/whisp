import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DarkModeToggle extends StatefulWidget {
  @override
  _DarkModeToggleState createState() => _DarkModeToggleState();
}

class _DarkModeToggleState extends State<DarkModeToggle> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDarkMode = !isDarkMode;
          // Implement dark mode toggle functionality here
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: Offset(4, 4)
              ),
              BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 15,
                  spreadRadius: 1,
                  offset: Offset(-4, -4)
              ),
            ]
        ),
        padding: EdgeInsets.all(8),
        child: Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: Colors.grey[700],
        ),
      ),
    );
  }
}