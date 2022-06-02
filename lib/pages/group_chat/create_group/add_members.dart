import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiledev/pages/group_chat/create_group/create_group.dart';

class AddMembersInGroup extends StatefulWidget {
  const AddMembersInGroup({Key? key}) : super(key: key);

  @override
  State<AddMembersInGroup> createState() => _AddMembersInGroupState();
}

class _AddMembersInGroupState extends State<AddMembersInGroup> {
  final TextEditingController _search = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> membersList = [];
  bool isLoading = false;
  bool isAdmin = false;
  Map<String, dynamic>? userMap;
  final fToast = FToast();

  @override
  void initState() {
    super.initState();
     getCurrentUserDetails();
    fToast.init(context);
  }

  void getCurrentUserDetails() async {
    await _firestore
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((map) {
      setState(() {
        membersList.add({
          "name": map['name'],
          "email": map['email'],
          "uid": map['uid'],
          "isAdmin": true,
        });
      });
    });
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

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
    _search.clear();
  }

  void onResultTap() {
    bool isAlreadyExist = false;

    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['uid'] == userMap!['uid']) {
        isAlreadyExist = true;
      }
    }

    if (!isAlreadyExist) {
      setState(() {
        membersList.add({
          "name": userMap!['name'],
          "email": userMap!['email'],
          "uid": userMap!['uid'],
          "isAdmin": false,
        });

        userMap = null;
      });
    }
  }

  void onRemoveMembers(int index) {
    if (membersList[index]['uid'] != _auth.currentUser!.uid) {
      setState(() {
        membersList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text("Adicionar Participantes",style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: membersList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () => onRemoveMembers(index),
                    leading: Icon(Icons.account_circle,color: Colors.blue.shade900),
                    title: Text(membersList[index]['name'],style: TextStyle(color: Colors.blue.shade900)),
                    subtitle: Text(membersList[index]['email'],style: TextStyle(color: Colors.blue.shade900)),
                    trailing: Icon(Icons.close,color: Colors.blue.shade900),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: size.height / 14,
                  width: size.height /2.6,
                  child: TextField(
                    autofocus: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue.shade900),
                    controller: _search,
                    decoration: InputDecoration(
                      hintText: "Localizar participantes",hintStyle: TextStyle(color: Colors.blue.shade900),
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
                      onPressed: onSearch,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height / 50,
            ),
            userMap != null
                ? ListTile(
              onTap: onResultTap,
              leading: Icon(Icons.account_box,color: Colors.blue.shade900),
              title: Text(userMap!['name'],style: TextStyle(color: Colors.blue.shade900)),
              subtitle: Text(userMap!['email'],style: TextStyle(color: Colors.blue.shade900)),
              trailing: Icon(Icons.add,color: Colors.blue.shade900),
            )
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: membersList.length >= 2
          ? FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        child: Icon(Icons.forward,color: Colors.white),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CreateGroup(
              membersList: membersList,
            ),
          ),
        ),
      )
          : SizedBox(),
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
}