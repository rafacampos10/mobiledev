import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiledev/services/methods.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({Key? key}) : super(key: key);

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final fToast = FToast();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    fToast.init(context);
  }

  void setStatus(String status) async {
    await _firestore.collection('usuarios').doc(_auth.currentUser?.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }

  String chatRoomId(dynamic user1, dynamic user2) {
    String uidUser1 = user1.uid;
    String uidUser2 = user2['uid'];

    if (uidUser1.toLowerCase().codeUnits[0] >
        uidUser2.toLowerCase().codeUnits[0]) {
      return "${uidUser1}:${uidUser2}";
    } else {
      return "${uidUser2}:${uidUser1}";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;


    await _firestore
        .collection('usuarios')
        .where("name", isEqualTo: _search.text)
        .get()
        .then((value) {
          setState(() {
            isLoading = true;
          });

          if(value.docs.isEmpty){
            fToast.showToast(
              child: buildToast(),
              toastDuration: Duration(seconds: 2),
              gravity: ToastGravity.BOTTOM,
            );
            setState(() {
              isLoading = false;
            });

            return;
          }

          userMap = value.docs[0].data();





          setState(() {
            isLoading = false;
          });

      });
  }

    @override
    Widget build(BuildContext context) {
      final size = MediaQuery
          .of(context)
          .size;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
          title: Text("Pesquisar", style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () => logOut(context))

          ],

        ),
        body: isLoading
            ? Center(
          child: Container(
            height: size.height / 20,
            width: size.height / 20,
            child: CircularProgressIndicator(
                color: Colors.blue.shade900),
          ),
        )
            : Column(
          children: [
            SizedBox(
              height: size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: size.height / 14,
                  width: size.height / 2.6,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue.shade900),
                    controller: _search,
                    decoration: InputDecoration(
                      hintText: "Localizar participantes",
                      hintStyle: TextStyle(color: Colors.blue.shade900),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: ClipRRect(
                    child: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.blue.shade900,
                      onPressed:onSearch,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: CupertinoActionSheet(
                cancelButton: CupertinoActionSheetAction(
                    isDefaultAction: true,
                    isDestructiveAction: true,
                    child: Text('Limpar busca',
                      style: TextStyle(color: Colors.blue.shade900),),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => HomeChat())
                      );
                    }
                ),
              ),
            ),

            userMap != null
                ? ListTile(
          onTap: () {


            if(userMap!['isChecked'] == true){
              String uid = _auth.currentUser!.uid;
              String uidFriend = userMap!['uid'];
              String roomId = chatRoomId(
                  _auth.currentUser,
                  userMap
              );

              _firestore
                  .collection('usuarios')
                  .doc(uid)
                  .collection('friends')
                  .doc(roomId)
                  .set({
                "name": _auth.currentUser!.displayName,
                "friend": userMap!['name'],
                "id": roomId,
              });

              _firestore
                  .collection('usuarios')
                  .doc(uidFriend)
                  .collection('friends')
                  .doc(roomId)
                  .set({
                "name": userMap!['name'],
                "friend": _auth.currentUser!.displayName,
                "id": roomId,
              });
              fToast.showToast(
                child: addFriends(),
                toastDuration: Duration(seconds: 3),
                gravity: ToastGravity.BOTTOM,
              );
            } else{
              fToast.showToast(
                child: chatDireto(),
                toastDuration: Duration(seconds: 3),
                gravity: ToastGravity.BOTTOM,
              );
            }


          },
          leading: Icon(Icons.account_box, color: Colors.blue.shade900),
          title: Text(
            userMap!['name'],
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(userMap!['email'],
              style: TextStyle(color: Colors.blue.shade900)),
          trailing: Icon(Icons.add, color: Colors.blue.shade900),
        )


                : Container(),
          ],
        ),
      );
    }
    Widget buildToast() =>
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red.shade900,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.close, color: Colors.white),
              SizedBox(
                width: 12.0,
              ),
              Text("Participante não encontrado",
                style: TextStyle(color: Colors.white),),
            ],
          ),
        );

  Widget chatDireto() =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.shade900,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.close, color: Colors.white),
            SizedBox(
              width: 12.0,
            ),
            Text("Esse usuário não ativou o chat direto.",
              style: TextStyle(color: Colors.white),),
          ],
        ),
      );
  Widget addFriends() =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.shade900,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
  <path d="M8 9a3 3 0 100-6 3 3 0 000 6zM8 11a6 6 0 016 6H2a6 6 0 016-6zM16 7a1 1 0 10-2 0v1h-1a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2h-1V7z" />
</svg>""", color: Colors.white,height: 24, width: 24),
            SizedBox(
              width: 12.0,
            ),
            Text("Amigo adicionado",
              style: TextStyle(color: Colors.white),),
          ],
        ),
      );


  }