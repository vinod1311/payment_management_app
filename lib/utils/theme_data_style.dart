import 'package:flutter/material.dart';


///------------------ Theme Data for using Theme color
class ThemeDataStyle {

  ///----- Theme data for light mode
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF549dff),
      secondary: Color(0xFF3366FF),
      surface: Color(0xFFFFFFFF),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    primaryColorLight: const Color(0xFFFFC1AC),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
    ),
    disabledColor: const Color(0xFF919EAB),
    dividerColor:  Colors.grey[200],
    cardColor: Colors.grey[100],
    scaffoldBackgroundColor: const Color(0xFFF9FAFB),

  );

  ///----- Theme data for dark mode
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF549dff),
      secondary: Color(0xFF3366FF),
      surface: Color(0xFF161C24),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2A3A48),
    ),
    primaryColorLight: const Color(0xFFFFC1AC),
    disabledColor: const Color(0xFF919EAB),
    dividerColor:  Colors.grey[200],
    cardColor: const Color(0xFF2A3A48),
    scaffoldBackgroundColor: const Color(0xFF212B36),
  );
}
