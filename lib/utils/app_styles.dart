import 'package:flutter/material.dart';

class AppStyles {
  
  static const Color primaryColor = Color(0xFF8A008A);
  static const Color darkPurple = Color(0xFF240046);
  static const Color lightPurple = Color.fromARGB(255, 57, 3, 57);
  static const Color backgroundColor = Color.fromARGB(255, 247, 247, 247);

  
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  
  static const TextStyle titleStyle = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: lightPurple,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  
  static AppBar buildAppBar(String title) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.grey[800],
    );
  }

  
  static const Icon headerIcon = Icon(
    Icons.stars,
    size: 60,
    color: lightPurple,
  );
}

