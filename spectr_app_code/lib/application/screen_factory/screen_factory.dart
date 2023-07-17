import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SmoothPageRoute extends CupertinoPageRoute {
  SmoothPageRoute({required WidgetBuilder builder, RouteSettings? settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: builder(context),
    );
  }
}

class ScreenFactory {
  // ignore: non_constant_identifier_names
  static void navigateToPage(BuildContext context, widgetBuilder) {
    Navigator.push(
        context, SmoothPageRoute(builder: (context) => widgetBuilder));
  }
}
