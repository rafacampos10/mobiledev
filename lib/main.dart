// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobiledev/services/auth_service.dart';
import 'package:mobiledev/services/notification_service.dart';
import 'package:mobiledev/widgets/custom_firebase_messaging.dart';
import 'dev.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await CustomFirebaseMessaging().inicialize();
  await CustomFirebaseMessaging().getTokenFirebase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        Provider<NotificationService>(create: (context) => NotificationService()),
      ],
      child: MeuAplicativo(),
    ),
  );
}

