
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NeumorphicTile extends StatelessWidget {
  final Widget child;

  const NeumorphicTile({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            offset: Offset(3, 3),
            blurRadius: 8,
          ),
          BoxShadow(
            color: Colors.grey.shade400,
            offset: Offset(-2, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: child,
    );
  }
}
