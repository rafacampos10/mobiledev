import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class roomDirect extends StatefulWidget {
  final String directChatId, directName;
  const roomDirect({Key? key, required this.directChatId, required this.directName});

  @override
  State<roomDirect> createState() => _roomDirectState();
}

class _roomDirectState extends State<roomDirect> {

  late ScrollController _scrollController = ScrollController();
  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void scrollToBottom(){
    final bottomOffset = -(_scrollController.position.maxScrollExtent + 49);
    print(bottomOffset);
    _scrollController.animateTo(
      bottomOffset,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onSendMessage() async {

    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser?.displayName,
        "message": _message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };


      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(widget.directChatId)
          .collection('chats')
          .add(messages);
    }
    scrollToBottom();
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        title: Text(widget.directName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height / 1.27,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(widget.directChatId)
                    .collection('chats')
                    .where('time',isGreaterThan: DateTime.now().subtract(Duration(days: 7)))
                    .orderBy('time',descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        Map<String, dynamic> chatMap =
                        snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;

                        return messages(size, chatMap);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 8,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                height: size.height / 10,
                width: size.width / 1.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height / 10,
                      width: size.width / 1.3,
                      child: TextField(
                        expands: true,
                        maxLines: null,
                        maxLength: 1000,
                        controller: _message,
                        decoration: InputDecoration(
                            counterStyle: TextStyle(color: Colors.black,fontSize: 15),
                            hintText: "Escreva sua mensagem",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send,color: Colors.blue.shade900), onPressed: onSendMessage),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser?.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blue.shade900,
        ),
        child: Text(
          map['message'],
          softWrap: true,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
