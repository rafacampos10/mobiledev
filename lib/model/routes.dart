import 'package:flutter/material.dart';
import 'package:mobiledev/pages/PageView/chat.dart';
import 'package:mobiledev/pages/PageView/notification.dart';
import 'package:mobiledev/pages/PageView/notification/Details_notify/details_notify.dart';
import 'package:mobiledev/pages/PageView/notification/Details_notify/details_notify_venc.dart';
import 'package:mobiledev/pages/login.dart';
import 'package:mobiledev/widgets/auth_check.dart';

class Routes{
  static Map<String,Widget Function(BuildContext)> list = <String,WidgetBuilder>{
    '/home': (_) => AuthCheck(),
    '/chat': (_) => const Chat(),
    '/login': (_) => LoginScreen(),
    '/notification': (_) =>const Notificacao(),
    '/details_notify_aviso': (_) =>const DetailsNotify(),
    '/details_notify_venc': (_) =>const DetailsNotifyVenc(),
  };
  static String initial = '/home';

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


}