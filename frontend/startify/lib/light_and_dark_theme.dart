import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color.fromRGBO(195, 244, 248, 1),
  iconTheme: const IconThemeData(color: Colors.black),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(195, 244, 248, 1), // AppBar color
    foregroundColor: Colors.black, // Text & icons color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor:
          Color.fromRGBO(224, 253, 255, 1), // Button color in light mode
      foregroundColor: Colors.black,
    ),
  ),
  colorScheme: ColorScheme.light(
    surface: Color.fromRGBO(195, 244, 248, 1), // NavigationBar background color
    secondaryContainer:
        Color.fromRGBO(224, 253, 255, 1), // Selected item indicator color
    onSecondaryContainer: Colors.black, // Selected item text color
    onSurface: Colors.black, // Unselected item text color
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xFF213349),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF213349), // AppBar color
    foregroundColor: Colors.white, // Text & icons color
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF2D526C), // Button color in dark mode
      foregroundColor: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.dark(
    surface: Color(0xFF213349), // NavigationBar background color
    secondaryContainer: Color(0xFF2D526C), // Selected item indicator color
    onSecondaryContainer: Colors.white, // Selected item text color
    onSurface: Colors.white, // Unselected item text color
  ),
);
