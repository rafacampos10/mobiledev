import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobiledev/components/chat/blur_image_page_scaffold.dart';
import 'package:mobiledev/components/chat/lets_start.dart';
import 'package:mobiledev/components/chat/logo.dart';
import 'package:mobiledev/pages/group_chat/group_chat_screen.dart';


class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurImagePageScaffold(
      imagePath: "images/aplicativo.png",
      body: [
        Logo(height: 150.0, width: 150.0, radius: 50.0),
        Text("Bem vindo",
            style:
            TextStyle(color: Colors.white, fontSize: 60)),
        Column(
          children: [
            Text("Chat do UniApp - ",
                style: TextStyle(
                    color: Colors.white, fontSize: 20)),
            Text("Fale diretamente com seus consultores",
                style: TextStyle(
                    color: Colors.white, fontSize: 20)),
            Text("e seus grupos de cursos",
                style: TextStyle(
                    color: Colors.white, fontSize: 20))
          ],
        ),
        LetsStart(onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => GroupChatHomeScreen()));
        })
      ],
    );
  }
}
