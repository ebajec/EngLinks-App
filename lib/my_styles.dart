import 'package:flutter/material.dart';

/* To contain any common button/text styles we would like to use
throughout the app.  This should make our code much more readable and give a lot
of consistency.*/
class MyButtonStyles {
  static ButtonStyle buttonStyleLarge(BuildContext context) {
    return ElevatedButton.styleFrom(
      primary: Theme.of(context).colorScheme.secondary,
      onPrimary: Colors.white,
      shadowColor: Theme.of(context).colorScheme.outline,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      minimumSize: Size(360, 120),
    );
  }
}

class MyTextStyles {
  static TextStyle titleLarge(BuildContext context) {
    return TextStyle(
        fontSize: 50,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 85, 56, 136));
  }

  static TextStyle titleMedium(BuildContext context) {
    return TextStyle(
        fontSize: 28,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 65, 65, 65));
  }

  static TextStyle bold(BuildContext context, double size) {
    return TextStyle(
        fontSize: size,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 65, 65, 65));
  }

  static TextStyle buttonLarge(BuildContext context) {
    return TextStyle(
      fontSize: 42,
      fontFamily: 'Helvetica',
    );
  }

  static TextStyle appBarLarge(BuildContext context) {
    return TextStyle(
        fontSize: 24,
        fontFamily: 'Helvetica',
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 85, 56, 136));
  }
}
