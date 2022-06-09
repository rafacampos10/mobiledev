import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class clientDetails extends StatefulWidget {
  const clientDetails({Key? key}) : super(key: key);

  @override
  State<clientDetails> createState() => _clientDetailsState();
}

class _clientDetailsState extends State<clientDetails> {
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
      //Alta Performance
      Container(
        margin: EdgeInsets.symmetric(horizontal: 35),
        width: MediaQuery.of(context).size.width,
        height: 270,
        child: Row(
          children: [
            Image.asset(
              "images/service-banner-atualizado.jpg",
              width: 320,
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height/2,
        width: MediaQuery.of(context).size.width,
        child: Text(
          "O web service 'Client-Server' é um projeto de conclusão no curso de Web Developer "
              "na escola People em Campinas-SP.\n"
              "Nesse projeto consta o CRUD (Create, Read, Update e Delete),"
              " sistema de buscas dinâmicas e listagem de usuários utilizando"
              " as seguintes linguagens de programação:\n"
              "- HTML5\n"
              "- CSS3\n"
              "- JavaScript\n"
              "- MySQL\n"
              "- PHP\n",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ],
    ),
    ),
    );
  }
}
