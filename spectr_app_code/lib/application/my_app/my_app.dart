import 'package:flutter/material.dart';
import 'package:spectr/application/navigation/main_navigation.dart';
import 'package:spectr/application/themes/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  final mainNavigation = MainNavigation();
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spectr',
      theme: AppTheme.light,
      initialRoute: '/',
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
