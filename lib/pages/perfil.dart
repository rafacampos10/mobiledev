import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiledev/pages/PageView/edit_page.dart';
import 'package:mobiledev/services/methods.dart';
import 'package:mobiledev/services/prefs_service.dart';

class perfilPage extends StatefulWidget {
  const perfilPage({Key? key}) : super(key: key);



  @override
  State<perfilPage> createState() => _perfilPageState();

}

class _perfilPageState extends State<perfilPage> {

  FirebaseAuth _auth = FirebaseAuth.instance;
  final Color azul = Colors.blue.shade900;
  final Color branco = Colors.white;
  var authUser;
  final fToast = FToast();

  void getUser() async {
    var userPrefs = await PrefsService.auth();
    setState(() {
      authUser = userPrefs;
    });
  }

  List firstLetter(String fullName) {
    return fullName.split(' ');
  }



  updateData(bool isChecked) async{
    await checkUpdate().updateUser(isChecked);
  }

  @override
  void initState() {
    super.initState();
    getUser();
    fToast.init(context);
  }


  @override
  Widget build(BuildContext context) {
    String uid = _auth.currentUser!.uid;

    final CollectionReference _usersStream =
    FirebaseFirestore.instance
        .collection("usuarios");

    return Scaffold(
      backgroundColor: azul,
      body: StreamBuilder<DocumentSnapshot>(
        stream: _usersStream.doc(uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            return SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/1.6,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child:
                          CircleAvatar(
                            radius: (52),
                            backgroundColor: azul,
                            child: FittedBox(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              child: NameIcon(
                                name: firstLetter(snapshot.data!['name'])[0],
                                lastName: firstLetter(snapshot.data!['name'])[1],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: ListTile(
                                  title: Text(snapshot.data!['name'],
                                    style: TextStyle(
                                      color: azul,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 60),
                              ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(snapshot.data!['email'],
                                        style: TextStyle(
                                          color: azul,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      leading: Icon(Icons.email,color: azul),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            title: Text((snapshot.data != null)
                                                ? ((snapshot.data!['phoneNumber'] != null)
                                                ? snapshot.data!['phoneNumber']
                                                : "")
                                                : "",
                                              style: TextStyle(
                                                color: azul,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            leading: Icon(Icons.phone, color: azul),
                                          ),
                                          ListTile(
                                            title: Text((snapshot.data != null)
                                                ? ((snapshot.data!['endereco'] != null)
                                                ? snapshot.data!['endereco']
                                                : "")
                                                : "",
                                              softWrap: true,
                                              style: TextStyle(
                                                color: azul,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            leading: Icon(Icons.location_on,color: azul),
                                          ),
                                          ListTile(
                                            title: Text((snapshot.data != null)
                                                ? ((snapshot.data!['cidade'] != null)
                                                ? snapshot.data!['cidade']
                                                : "")
                                                : "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: azul,
                                              ),
                                            ),
                                            leading: Icon(Icons.apartment,color: azul,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Checkbox(
                              fillColor: MaterialStateProperty.all(azul),
                              checkColor: Colors.white,
                              onChanged: (bool? value){
                                snapshot.data!['isChecked'] == value;
                                bool isChecked() => snapshot.data!['isChecked'];

                                if(snapshot.data!['isChecked'] != value){

                                  setState(() {
                                    checkUpdate().updateUser(isChecked());
                                  });

                                  if(snapshot.data!["isChecked"] == false){
                                    fToast.showToast(
                                      child: directActive(),
                                      toastDuration: Duration(seconds: 2),
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  } else{
                                    fToast.showToast(
                                      child: buildToast(),
                                      toastDuration: Duration(seconds: 2),
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }

                                }
                              },
                              value: snapshot.data!['isChecked'],
                            ),
                            Text(
                              "Permitir direct?",
                              style: TextStyle(
                                color: azul,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),

                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          height: 40,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),

                          child: SizedBox.expand(
                            child: TextButton(
                              child: Text(
                                "Alterar Dados",
                                style: TextStyle(
                                  color: azul,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed:(){ Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EditPage(),
                                  )
                              );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if(snapshot.hasError){
            const Text ("Houve um erro, tente novamente");
          }
          return Center(
            child: CircularProgressIndicator(color: branco),
          );
        },
      )
    );
  }

  Widget buildToast() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red.shade900,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
                        </svg>""", color: Colors.white,
            height: 24,
            width: 24),
        SizedBox(
          width: 12.0,
        ),
        Text("Chat direto está desativado",style: TextStyle(color: Colors.white),),
      ],
    ),
  );

  Widget directActive() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.green.shade900,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.string("""<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                        <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
                        </svg>""", color: Colors.white,
            height: 24,
            width: 24),
        SizedBox(
          width: 12.0,
        ),
        Text("Chat direto está ativado",style: TextStyle(color: Colors.white),),
      ],
    ),
  );
}
class NameIcon extends StatefulWidget {
  String name;
  String lastName;

  NameIcon({Key? key, required this.name, required this.lastName}) : super(key: key);

  @override
  State<NameIcon> createState() => _NameIconState();
}

class _NameIconState extends State<NameIcon> {

  String get firstLetter => this.widget.name.substring(0,1).toUpperCase();

  String get lastLetter => this.widget.lastName.substring(0,1).toUpperCase();


  @override
  Widget build(BuildContext context) {
    print(widget.name);
    print(widget.lastName);

    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(this.firstLetter + this.lastLetter, style: TextStyle(color: Colors.white,fontSize: 30)),
      ),
    );
  }
}