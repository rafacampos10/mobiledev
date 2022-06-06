import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AltaDetails extends StatefulWidget {
  const AltaDetails({Key? key}) : super(key: key);

  @override
  State<AltaDetails> createState() => _AltaDetailsState();
}

class _AltaDetailsState extends State<AltaDetails> {
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
      //Alta Performance
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: 270,
        child: Row(
          children: [
            Image.asset(
              "images/altaperformance-banner.png",
              width: 340,
              color: Colors.white,
            ),
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 420,
        width: MediaQuery.of(context).size.width,
        child: Text(
          "A oportunidade que você precisa está chegando...\n"
              "Para te guiar, alavancar o seu Marketplace e fazer com que você"
              " fature os 4 Mil Todo Santo Dia!\n"
              "Um curso com metodologia e estratégias validades na prática, por mim"
          "Alexandre Nogueira, com um gua dos passos que dever ser seguidos na sua"
          "operação. Além das aulas gravadas o curso se consiste com 3 aulas ao vivo"
          "toda semana, além de grupo exclusivo no telegram, time de suporte 100%"
          "capacitado disponível a todo momento e muito mais.\n"
          "Atenção: Na página de compras utilize o mesmo e-mail do aplicativo "
        "UniApp.",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      Container(
        height: 35,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              "Seja Avisado De Próximas Turmas!",
              style: TextStyle(
                color: Colors.white,

                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            onPressed: _alta,
          ),
        ),
      ),
    ],
    ),
    ),
    );
  }
}

_alta() async{
  const urlAlta =
      "https://universidademarketplaces.com.br/alta-performance-nos-marketplaces-cpt/";
  if (await canLaunch(urlAlta)) {
    await launch(urlAlta);
    print("Deu Certo !");
  } else {
    throw '$urlAlta não foi encontrado';
  }
}
