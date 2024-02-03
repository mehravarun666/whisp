import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeumorphicSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      margin: EdgeInsets.all(16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.search, color: Colors.grey),
          ),
          onChanged: (value) {
            // Handle search functionality here
          },
        ),
      ),
    );
  }
}