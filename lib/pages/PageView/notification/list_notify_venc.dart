import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobiledev/pages/PageView/notification/Details_notify/details_notify_venc.dart';

class ListNotifyVenc extends StatefulWidget {
  const ListNotifyVenc({Key? key}) : super(key: key);

  @override
  State<ListNotifyVenc> createState() => _ListNotifyVencState();
}

class _ListNotifyVencState extends State<ListNotifyVenc> {
  deleteTodo(item) {

    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('notify_venc').doc(item);

    documentReference.delete().whenComplete(() => print("Deletado com sucesso"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Vencimentos",style: TextStyle(color: Colors.blue.shade900)),
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('notify_venc').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
                  return Dismissible(
                    key: Key(index.toString()),
                    child: Card(
                      color: Colors.blue.shade900,
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      elevation: 10,
                      child: ListTile(
                        leading:Icon(Icons.calendar_month, color: Colors.white,size: 30),
                        title: Text((documentSnapshot != null) ? (documentSnapshot["title"]) : "",style: TextStyle(color: Colors.white,fontSize: 20)),
                        subtitle: Text((documentSnapshot != null)
                            ? ((documentSnapshot["subtitle"] != null)
                            ? documentSnapshot["subtitle"]
                            : "")
                            : "",style: TextStyle(color: Colors.white,fontSize: 15)),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.white),
                        onLongPress: (){
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context){
                                return Container(
                                  color: Colors.blue.shade900,
                                  child: new Wrap(
                                    children: <Widget>[
                                      new ListTile(
                                          trailing: new Icon(Icons.delete,color: Colors.white),
                                          onTap: () {
                                            setState(() {
                                              deleteTodo((documentSnapshot != null) ? (documentSnapshot["title"]) : "");
                                            });
                                          }
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        },
                        onTap:() => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) =>
                                  DetailsNotifyVenc()
                          ),
                        ),
                      ),
                    ),
                  );
                }
            );
          },
        ),
      ),
    );
  }
}
