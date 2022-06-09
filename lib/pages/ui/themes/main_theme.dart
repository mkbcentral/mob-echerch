import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
      primarySwatch: Colors.blue,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        foregroundColor: Colors.white,

        //<-- SEE HERE
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.green,
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
