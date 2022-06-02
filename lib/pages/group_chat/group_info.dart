import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiledev/pages/group_chat/add_members.dart';
import 'package:mobiledev/pages/home_page.dart';

class GroupInfo extends StatefulWidget {
  final String groupId, groupName;
  const GroupInfo({required this.groupId, required this.groupName, Key? key})
      : super(key: key);

  @override
  State<GroupInfo> createState() => _GroupInfoState();
}

class _GroupInfoState extends State<GroupInfo> {
  List membersList = [];
  bool isLoading = true;
  final fToast = FToast();

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getGroupDetails();
    fToast.init(context);
  }

  Future getGroupDetails() async {
    await _firestore
        .collection('groups')
        .doc(widget.groupId)
        .get()
        .then((chatMap) {
      membersList = chatMap['members'];
      print(membersList);
      isLoading = false;
      setState(() {});
    });
  }

  bool checkAdmin() {
    bool isAdmin = false;

    membersList.forEach((element) {
      if (element['uid'] == _auth.currentUser!.uid) {
        isAdmin = element['isAdmin'];
      }
    });
    print(isAdmin);

    return isAdmin;
  }

  Future removeMembers(int index) async {
    String uid = membersList[index]['uid'];

    setState(() {
      isLoading = true;
      membersList.removeAt(index);
    });

    await _firestore.collection('groups').doc(widget.groupId).update({
      "members": membersList,
    }).then((value) async {
      await _firestore
          .collection('usuarios')
          .doc(uid)
          .collection('groups')
          .doc(widget.groupId)
          .delete();

      setState(() {
        isLoading = false;
      });
    });
  }

  void showDialogBox(int index) {
    if (checkAdmin()) {
      if (_auth.currentUser!.uid != membersList[index]['uid']) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: ListTile(
                  title: Text("Deseja remover participante?"),
                ),
                actions: <Widget>[
                  TextButton(
                      onPressed: (){
                        removeMembers(index);
                        Navigator.of(context).pop();
                      },
                      child: Text("Sim"),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    child: Text("Não"),
                  )

                ],
              );
            });
      }
    }
  }

  Future onLeaveGroup() async {
    if (!checkAdmin()) {
      setState(() {
        isLoading = true;
      });

      for (int i = 0; i < membersList.length; i++) {
        if (membersList[i]['uid'] == _auth.currentUser!.uid) {
          membersList.removeAt(i);
        }
      }

      await _firestore.collection('groups').doc(widget.groupId).update({
        "members": membersList,
      });

      await _firestore
          .collection('usuarios')
          .doc(_auth.currentUser!.uid)
          .collection('groups')
          .doc(widget.groupId)
          .delete();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => HomePage()),
            (route) => false,
      );
    }
  }

    @override
    Widget build(BuildContext context) {
      final Size size = MediaQuery
          .of(context)
          .size;

      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.blue.shade900,
          body: isLoading
              ? Container(
            height: size.height,
            width: size.width,
            alignment: Alignment.center,
            child: CircularProgressIndicator(color: Colors.white),
          )
              : SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(color: Colors.white),
                ),
                Container(
                  height: size.height / 8,
                  width: size.width / 1.1,
                  child: Row(
                    children: [
                      Container(
                        height: size.height / 11,
                        width: size.height / 11,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.group,
                          color: Colors.blue.shade900,
                          size: size.width / 10,
                        ),
                      ),
                      SizedBox(
                        width: size.width / 20,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.groupName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: size.width / 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //

                SizedBox(
                  height: size.height / 20,
                ),

                Container(
                  width: size.width / 1.1,
                  child: Text(
                    "${membersList.length} Participantes",
                    style: TextStyle(
                        fontSize: size.width / 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height / 20,
                ),

                // Members Name

                checkAdmin()
                    ? ListTile(
                  onTap: () =>
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              AddMembersINGroup(
                                groupChatId: widget.groupId,
                                name: widget.groupName,
                                membersList: membersList,
                              ),
                        ),
                      ),
                  leading: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  title: Text(
                    "Adicionar Membros",
                    style: TextStyle(
                        fontSize: size.width / 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white
                    ),
                  ),
                )
                    : SizedBox(),

                Flexible(
                  child: ListView.builder(
                    itemCount: membersList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => showDialogBox(index),
                        leading: Icon(Icons.account_circle,
                            color: Colors.white),
                        title: Text(
                          membersList[index]['name'],
                          style: TextStyle(
                            fontSize: size.width / 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(membersList[index]['email'],
                            style: TextStyle(
                                color: Colors.white)
                        ),
                        trailing: Text(
                            membersList[index]['isAdmin'] ? "Admin" : "Participantes", style: TextStyle(color: Colors.white),)
                      );
                    },
                  ),
                ),

                ListTile(
                  onTap: onLeaveGroup,
                  leading: Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  title: Text(
                    "Sair do grupo",
                    style: TextStyle(
                      fontSize: size.width / 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  Widget memberRemove() =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.shade900,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.group, color: Colors.white),
            SizedBox(
              width: 12.0,
            ),
            Text("Participante removido",
              style: TextStyle(color: Colors.white),),
          ],
        ),
      );
  }