import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String userEmail;
  const ConfirmationDialog({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 60),
          SizedBox(height: 20),
          Text('Confirmed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Email sent to $userEmail", textAlign: TextAlign.center),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF8A008A)),
            onPressed: () => Navigator.pop(context),
            child: Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}