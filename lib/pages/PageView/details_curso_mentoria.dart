import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MentoriaDetails extends StatefulWidget {
  const MentoriaDetails({Key? key}) : super(key: key);

  @override
  State<MentoriaDetails> createState() => _MentoriaDetailsState();
}

class _MentoriaDetailsState extends State<MentoriaDetails> {
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

      backgroundColor: Colors.blue.shade900,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Mentoria
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: Row(
                children: [
                  Image.asset(
                    "images/mentoria.png",
                    width: 340,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 320,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Entenda como a Mentoria pode alavancar as suas vendas nos Marketplaces!\n"
                    "Nosso time de consultores irá trabalhar pessoalmente com você, "
                    "face a face com seu negócio, para te ajudar a triplicar seu"
                    " faturamento nos marketplaces, com plano de ação e estratégias "
                    "validadas na prática nos próximos 4 meses.\n"
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
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                    "Quero Falar via Whatsapp",
                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: _mentoria,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_mentoria() async {
  const urlMentoria =
      "https://universidademarketplaces.com.br/mentoria-marketplaces/?utm_source=site_uni&utm_medium=secao_mentoria&utm_campaign=site_uni_para_mentoria_030321";
  if (await canLaunch(urlMentoria)) {
    await launch(urlMentoria);
    print("Deu Certo !");
  } else {
    throw '$urlMentoria não foi encontrado';
  }
}
