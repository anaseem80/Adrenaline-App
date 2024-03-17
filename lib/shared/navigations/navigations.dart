import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationFunctions {
  static Future<void> routingPage({
    required BuildContext context,
    required Widget page,
  }) async {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  static Future<void> routingPageWithReplacement({
    required BuildContext context,
    required Widget page,
  }) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page));
  }

  static Future<void> navigateAndDeleteAll({
    required BuildContext context,
    required Widget page,
  }) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
            (Route<dynamic> route) => false);
  }
}