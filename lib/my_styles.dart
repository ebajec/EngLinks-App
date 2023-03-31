import 'package:flutter/material.dart';

/* To contain any common button/text styles we would like to use
throughout the app.  This should make our code much more readable and give a lot
of consistency.*/
class MyButtonStyles {
  static ButtonStyle buttonStyleLarge(BuildContext context) {
    return ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
            color: Colors.black,
            width: 2.0, // adjust border width as needed
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        backgroundColor: Theme.of(context).colorScheme.background,
        minimumSize: Size(300, 120));
  }
}

class MyTextStyles {
  static TextStyle titleLarge(BuildContext context) {
    return TextStyle(
        fontSize: 46,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Colors.purple);
  }

  static TextStyle titleMedium(BuildContext context) {
    return TextStyle(
        fontSize: 28,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 45, 45, 45));
  }

  static TextStyle bold(BuildContext context, double size) {
    return TextStyle(
        fontSize: size,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 45, 45, 45));
  }

  static TextStyle buttonLarge(BuildContext context) {
    return TextStyle(
        fontSize: 42,
        fontFamily: 'Helvetica',
        color: Color.fromARGB(255, 45, 45, 45));
  }

  static TextStyle appBarLarge(BuildContext context) {
    return TextStyle(
        fontSize: 24,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 85, 56, 136));
  }
}
