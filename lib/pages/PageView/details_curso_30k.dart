import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class trintakDetails extends StatefulWidget {
  const trintakDetails({Key? key}) : super(key: key);

  @override
  State<trintakDetails> createState() => _trintakDetailsState();
}

class _trintakDetailsState extends State<trintakDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,

        actions: [
          Container(
            margin: EdgeInsets.only(left: 135, right: 165, top: 5),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                      "images/aplicativo.png",
                      color: Colors.blue.shade900,
                      height: 40,
                      width: 35),
                ],
              ),
            ),
          )
        ],

      ),

      backgroundColor: Colors.blue.shade900,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      //Curso 30k
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: Row(
          children: [
            Image.asset(
              "images/30k.png",
              width: 340,
              color: Colors.white,
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 250,
        width: MediaQuery.of(context).size.width,
        child: Text(
          "O Curso Mercado Livre Meus Primeiros 30K é um Curso Prático, "
              "todo em vídeo aulas onde vou te ensinar passo a passo, como"
              " ter resultados incríveis no maior marketplace do Brasil, "
              "através de estratégias exclusivas. É exatamente o que você "
              "precisa para chegar no status de Mercado Líder em cerca de "
              "6 meses.\n"
          "Atenção: Na página de compras utilize o mesmo e-mail do aplicativo "
              "UniApp. ",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 35,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.3, 1],
            colors: [
              Colors.blue.shade500,
              Colors.blue.shade800,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),

        child: SizedBox.expand(
          child: TextButton(
            child: Text(
              "Quero ser Mercado Líder !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: _pagamento30k,
          ),
        ),
      ),
            ],
        ),
      ),
    );
  }
}

_pagamento30k() async{
  const url = "https://pay.hotmart.com/R12850359P?off=u664k0se&_hi=eyJjaWQiOiIxNjQ0NDExOTU2NDMwNjA5NzYzOTA5MDk4NDk1MDAwIiwiYmlkIjoiMTY0NDQxMTk1NjQzMDYwOTc2MzkwOTA5ODQ5NTAwMCIsInNpZCI6IjY3MGZmNWRmZDFhZDRkNjRiNDVjNWFiNTRiYWI0YmViIn0%3D.1647258759132&checkoutMode=0&bid=1647258757807";
  if (await canLaunch(url)){
    await launch(url);
    print("Realizado com sucesso !");
  } else{
    throw "$url não encontrado";
  }
}
