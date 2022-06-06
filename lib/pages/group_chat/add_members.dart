import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddMembersINGroup extends StatefulWidget {
  final String groupChatId, name;
  final List membersList;
  const AddMembersINGroup(
      {required this.name,
        required this.membersList,
        required this.groupChatId,
        Key? key})
      : super(key: key);

  @override
  _AddMembersINGroupState createState() => _AddMembersINGroupState();
}

class _AddMembersINGroupState extends State<AddMembersINGroup> {
  final TextEditingController _search = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  List membersList = [];
  final fToast = FToast();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    membersList = widget.membersList;
    fToast.init(context);
  }

  void onSearch() async {
    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('usuarios')
        .where('email',isEqualTo: _search.text)
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

  void onAddMembers() async {
    bool isAlreadyExist = false;
    membersList.add(userMap);
    for (int i = 0; i < membersList.length; i++) {
      if (membersList[i]['uid'] == userMap!['uid']) {
        isAlreadyExist = true;
        fToast.showToast(
          child: memberExists(),
          toastDuration: Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM,
        );

      }
    }

    if (!isAlreadyExist) {
      setState(() {
        membersList.add({
          "name": userMap!['name'],
          "email": userMap!['email'],
          "uid": userMap!['uid'],
          "isAdmin": userMap!['isAdmin'],
        });
        fToast.showToast(
          child: memberAdd(),
          toastDuration: Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM,
        );

        userMap = null;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text("Adicionar"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
            userMap != null
                ? ListTile(
              onTap: onAddMembers,
              leading: Icon(Icons.account_box,color: Colors.blue.shade900),
              title: Text(userMap!['name'],style: TextStyle(color: Colors.blue.shade900)),
              subtitle: Text(userMap!['email'],style: TextStyle(color: Colors.blue.shade900)),
              trailing: Icon(Icons.add,color: Colors.blue.shade900),
            )
                : SizedBox(),
          ],
        ),
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

  Widget memberExists() =>
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
            Text("Já foi adicionado no grupo",
              style: TextStyle(color: Colors.white),),
          ],
        ),
      );

  Widget memberAdd() =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.shade900,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.group, color: Colors.white),
            SizedBox(
              width: 12.0,
            ),
            Text("Participante adicionado",
              style: TextStyle(color: Colors.white),),
          ],
        ),
      );
}