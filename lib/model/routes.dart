import 'package:flutter/material.dart';
import 'package:mobiledev/pages/PageView/chat.dart';
import 'package:mobiledev/pages/login.dart';
import 'package:mobiledev/widgets/auth_check.dart';

class Routes{
  static Map<String,Widget Function(BuildContext)> list = <String,WidgetBuilder>{
    '/home': (_) => AuthCheck(),
    '/chat': (_) => const Chat(),
    '/login': (_) => LoginScreen(),
  };
  static String initial = '/home';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


}