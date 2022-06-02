import 'package:flutter/material.dart';
import 'package:mobiledev/model/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MeuAplicativo extends StatefulWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  State<MeuAplicativo> createState() => _MeuAplicativoState();
}


class _MeuAplicativoState extends State<MeuAplicativo> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.initial,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}