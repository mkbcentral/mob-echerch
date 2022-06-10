import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        foregroundColor: Color.fromARGB(255, 57, 48, 48),

        //<-- SEE HERE
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.transparent,
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
          fontSize: 14,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
        iconTheme:
            MaterialStateProperty.all(const IconThemeData(color: Colors.white)),
      ));

  static final dark =
      ThemeData(primaryColorLight: Colors.yellow, brightness: Brightness.dark);
}
