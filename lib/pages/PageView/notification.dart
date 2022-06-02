import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobiledev/pages/PageView/notification/list_notify_aviso.dart';
import 'package:mobiledev/pages/PageView/notification/list_notify_venc.dart';


class Notificacao extends StatefulWidget {
  const Notificacao({Key? key}) : super(key: key);

  @override
  State<Notificacao> createState() => _NotificacaoState();
}

class _NotificacaoState extends State<Notificacao> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List notification = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  void notificationAviso() async {

    await _firestore.collection('notification').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(child: Text(
              "Alertas",
              style: TextStyle(
                  color: Colors.white,fontSize: 25),
            ),
                margin: EdgeInsets.symmetric(vertical: 30)),
            Divider(color: Colors.white,thickness: 2),
            Container(
              height: MediaQuery.of(context).size.height/10,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ListNotifyAviso(),
                        ),
                      );
                    },
                    leading: Icon(Icons.error, color: Colors.white),
                    title: Text( "Avisos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
            ),
            ),
      Divider(color: Colors.white,thickness: 2),
            Container(
              height: MediaQuery.of(context).size.height/10,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ListNotifyVenc(),
                        ),
                      );
                    },
                    leading: Icon(Icons.calendar_month, color: Colors.white),
                    title: Text( "Vencimentos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.white,thickness: 2),
          ],
        ),
      ),
    );
  }
}
