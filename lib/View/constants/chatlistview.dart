import 'package:flutter/material.dart';

class NeumorphicTile extends StatelessWidget {
  final Widget child;
  final VoidCallback onDismissed;

  const NeumorphicTile({Key? key, required this.child, required this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('unique_key'), // provide a unique key for each Dismissible
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // Show confirmation dialog
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirm Delete'),
                content: Text('Are you sure you want to delete this item?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false); // Dismiss dialog
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true); // Confirm delete
                    },
                    child: Text('Delete'),
                  ),
                ],
              );
            },
          );
        }
        return true;
      },
      onDismissed: (_) => onDismissed(),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red.shade300,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.symmetric(vertical: 8),
        // customize the background color for sliding
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Icon(
              Icons.delete,
              color: Colors.white,
              size: 35,
            ),
            Text("Delete",style: TextStyle(fontFamily: 'Whisp',color: Colors.white,fontSize: 22),)
          ],
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width-20,
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
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
      ),
    );
  }
}
