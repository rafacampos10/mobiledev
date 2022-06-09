import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class uniappDetails extends StatefulWidget {
  const uniappDetails({Key? key}) : super(key: key);

  @override
  State<uniappDetails> createState() => _uniappDetailsState();
}

class _uniappDetailsState extends State<uniappDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(0,76,63,1),
        foregroundColor: Colors.white,

        actions: [
          Container(
            margin: EdgeInsets.only(left: 135, right: 165, top: 5),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                      "images/aplicativo.png",
                      height: 40,
                      width: 35),
                ],
              ),
            ),
          )
        ],

      ),

      backgroundColor: Color.fromRGBO(0,76,63,1),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      //Curso 30k
      Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        width: MediaQuery.of(context).size.width,
        height: 270,
        child: Row(
          children: [
            Image.asset(
              "images/uniapp.png",
              width: 320,
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height/2.5,
        width: MediaQuery.of(context).size.width,
        child: Text(
          "O aplicativo UniApp foi desenvolvido, para substituir o telegram da universidade"
              "para haver conversas entre os grupos de cursos e também os consultores para tirar "
              "dúvidas e interagir.\n"
          "As linguagens utilizadas no projeto foram:\n"
              "- Linguagem Dart\n"
              "- Framework Flutter\n"
              "- Banco de dados Firebase\n"
              "- Design Figma\n",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
      ]
        )
      )
    );
  }
}
