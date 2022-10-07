import 'package:flutter/material.dart';

class KTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        backgroundColor: Colors.white,
        fontFamily: "Poppins",
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        backgroundColor: Colors.black,
        fontFamily: "Poppins",
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
        ));
  }
}
