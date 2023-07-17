import 'package:flutter/material.dart';
import 'package:spectr/application/screens/main_menu.dart';
import 'package:spectr/application/screens/pin_code.dart';

import 'package:spectr/application/screens/start_sreen.dart';
import 'package:spectr/application/screens/authorization.dart';

abstract class Screens {
  static const mainPage = "/main";
  static const authorization = "/authorization";
  static const pincode = "/pincode";
  static const start = "/";
}

class MainNavigation {
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        Screens.pincode: (_) => PinCodePage(),
        Screens.mainPage: (_) => const MainPageScreen(),
        Screens.start: (_) => const StartScreen(),
        Screens.authorization: (_) => const AuthorizationScreen(),
      };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return null;
  }
}
