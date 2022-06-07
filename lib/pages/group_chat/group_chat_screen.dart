import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobiledev/pages/PageView/home_chat.dart';
import 'package:mobiledev/pages/PageView/roomchat.dart';
import 'package:mobiledev/pages/group_chat/create_group/add_members.dart';
import 'package:mobiledev/pages/group_chat/group_chat_room.dart';
import 'package:mobiledev/services/prefs_service.dart';

class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({Key? key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = true;

  List groupList = [];
  List chatList = [];
  var authUser;

  @override
  void initState() {
    super.initState();
    getUser();
    getAvailableGroups();
    getAvailableChat();
  }

  delete(int index) {
    String uid = _auth.currentUser!.uid;
    String chat = chatList[index]['id'];

    setState(() {
      isLoading = true;
      chatList.removeAt(index);
    });

    _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('friends')
        .doc(chat)
        .delete();
  }

  void showDialogBox(int index) {
    if (_auth.currentUser!.uid != chatList[index]['id']) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: ListTile(
                title: Text("Deseja realmente excluir essa conversa?"),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    delete(index);
                    Navigator.of(context).pop();
                  },
                  child: Text("Sim"),
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text("Não")
                )
              ],
            );
          });
    }
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        isLoading = false;
      });
    });
  }

  void getAvailableChat() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('usuarios')
        .doc(uid)
        .collection('friends')
        .get()
        .then((value) {
      setState(() {
        chatList = value.docs;
        isLoading = false;
      });
    });
  }

  void getUser() async {
    var userPrefs = await PrefsService.auth();
    setState(() {
      authUser = userPrefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    String uid = _auth.currentUser!.uid;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 76, 63, 1),
          centerTitle: true,
          title: Text("Conversas", style: TextStyle(color: Colors.white)),
        ),
        body: SafeArea(
            child: Column(children: [
          Flexible(
            child: ListView.builder(
              itemCount: groupList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GroupChatRoom(
                        groupName: groupList[index]['name'],
                        groupChatId: groupList[index]['id'],
                      ),
                    ),
                  ),
                  leading: Icon(Icons.group, color: Color.fromRGBO(0, 76, 63, 1)),
                  title: Text(groupList[index]['name']),
                );
              },
            ),
          ),
          Divider(
            thickness: 2,
          ),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('usuarios')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return snapshot.data!['isChecked']
                    ? Flexible(
                        child: ListView.builder(
                          itemCount: chatList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => roomDirect(
                                      directChatId: chatList[index]['id'],
                                      directName: chatList[index]['friend'],
                                    ),
                                  ),
                                );
                              },
                              trailing: Icon(
                                Icons.delete,
                                color: Color.fromRGBO(0, 76, 63, 1),
                              ),
                              onLongPress: () => showDialogBox(index),
                              leading: SvgPicture.string(
                                  """<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
                        </svg>""",
                                  color: Color.fromRGBO(0, 76, 63, 1),
                                  height: 24,
                                  width: 24),
                              title: Text(chatList[index]['friend']),
                            );
                          },
                        ),
                      )
                    : Container();
              }),
        ])),
        floatingActionButton: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('usuarios')
                .doc(uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SpeedDial(
                  backgroundColor: Color.fromRGBO(0, 76, 63, 1),
                  animatedIcon: AnimatedIcons.menu_close,
                  children: [
                    snapshot.data!['isChecked']
                        ? SpeedDialChild(
                            backgroundColor: Color.fromRGBO(0, 76, 63, 1),
                            child: Icon(Icons.search, color: Colors.white),
                            label: "Pesquisar participantes",
                            labelStyle: TextStyle(color: Colors.white),
                            labelBackgroundColor: Color.fromRGBO(0, 76, 63, 1),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => HomeChat(),
                              ),
                            ),
                          )
                        : SpeedDialChild(),
                    snapshot.data!['isAdmin']
                        ? SpeedDialChild(
                            backgroundColor: Color.fromRGBO(0, 76, 63, 1),
                            child: SvgPicture.string(
                                """<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
            <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z" />
            </svg>""",
                                color: Colors.white, height: 24, width: 24),
                            label: "Criar Grupos",
                            labelStyle: TextStyle(color: Colors.white),
                            labelBackgroundColor: Color.fromRGBO(0, 76, 63, 1),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => AddMembersInGroup(),
                              ),
                            ),
                          )
                        : SpeedDialChild(),
                  ]);
            }));
  }
}
