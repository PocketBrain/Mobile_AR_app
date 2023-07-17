import 'package:flutter/material.dart';
import 'package:spectr/application/themes/app_colors.dart';

// final kLightTheme = _buildLightTheme();
// final kDarkTheme = _buildDarkTheme();

const maxScreenWidth = 400.0;

abstract class AppTheme {
  static final light = ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: AppColors.darkBackground,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.green,
      unselectedItemColor: AppColors.darkText,
    ),
  );
}

// ThemeData _buildLightTheme() {
//   const Color primaryColor = Color.fromARGB(255, 255, 255, 255);
//   const Color secondaryColor = Color.fromARGB(255, 91, 43, 168);
//   final ColorScheme colorScheme = const ColorScheme.light().copyWith(
//     primary: primaryColor,
//     secondary: secondaryColor,
//   );
//   final ThemeData base = ThemeData(
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//       backgroundColor: Colors.white,
//       selectedItemColor: Color.fromARGB(255, 91, 43, 168),
//       unselectedItemColor: Color.fromARGB(255, 200, 200, 201),
//     ),
//     brightness: Brightness.light,
//     colorScheme: colorScheme,
//     primaryColor: primaryColor,
//     indicatorColor: Colors.white,
//     toggleableActiveColor: const Color(0xFF1E88E5),
//     splashColor: Colors.white24,
//     splashFactory: InkRipple.splashFactory,
//     canvasColor: Colors.white,
//     scaffoldBackgroundColor: Colors.white,
//     backgroundColor: Colors.white,
//     errorColor: const Color(0xFFB00020),
//     buttonTheme: ButtonThemeData(
//       colorScheme: colorScheme,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
//   return base.copyWith(
//     textTheme: base.textTheme,
//     primaryTextTheme: base.primaryTextTheme,
//   );
// }

// ThemeData _buildDarkTheme() {
//   const Color primaryColor = Color(0xFF0175c2);
//   const Color secondaryColor = Color(0xFF13B9FD);
//   final ColorScheme colorScheme = const ColorScheme.dark().copyWith(
//     primary: primaryColor,
//     secondary: secondaryColor,
//   );
//   final ThemeData base = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: primaryColor,
//     primaryColorDark: const Color(0xFF0050a0),
//     primaryColorLight: secondaryColor,
//     indicatorColor: Colors.white,
//     toggleableActiveColor: const Color(0xFF6997DF),
//     canvasColor: const Color(0xFF202124),
//     scaffoldBackgroundColor: const Color(0xFF202124),
//     backgroundColor: const Color(0xFF202124),
//     errorColor: const Color(0xFFB00020),
//     buttonTheme: ButtonThemeData(
//       colorScheme: colorScheme,
//       textTheme: ButtonTextTheme.primary,
//     ),
//   );
//   return base.copyWith(
//     textTheme: base.textTheme,
//     primaryTextTheme: base.primaryTextTheme,
//   );
// }
