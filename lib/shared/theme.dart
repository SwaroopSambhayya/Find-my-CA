import 'package:flutter/material.dart';

Color primaryColor = const Color(0xff6C4AB6);
Color secondaryColor = Colors.white;
Color backgroundColor = Colors.grey[100]!;
ThemeData lightThemeData = ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    fontFamily: 'Poppins',
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xff6C4AB6)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: secondaryColor,
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
    cardTheme: CardTheme(
      color: secondaryColor,
    ),
    canvasColor: backgroundColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: secondaryColor);

ThemeData darkThemeData = ThemeData.dark(
  useMaterial3: true,
).copyWith(
  primaryColor: primaryColor,
  buttonTheme: const ButtonThemeData(buttonColor: Color(0xff6C4AB6)),
);
