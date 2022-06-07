import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class autoDetails extends StatefulWidget {
  const autoDetails({Key? key}) : super(key: key);

  @override
  State<autoDetails> createState() => _autoDetailsState();
}

class _autoDetailsState extends State<autoDetails> {
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
            //Curso Bling
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage("images/bling.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 320,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "São mais de 60 aulas com profissionais certificados "
                    "do Bling descomplicando todos os processos "
                    "do seu negócio, além de aulas "
                    "estratégicas com o time da Universidade Marketplaces."
                    "Participe do Curso Bling Descomplicado e descubra como emitir"
                    " notas automaticamente, gerenciar seu estoque "
                    "e integrar ele com os principais marketplaces "
                    "de forma simples!\n"
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
                    "Quero Descomplicar Agora Minha Integração",
                    style: TextStyle(
                      color: Colors.white,

                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: _bling,
                ),
              ),
            ), //Curso Bling
          ],
        ),
      ),
    );
  }
}

_bling() async {
  const urlBling =
      "https://payment.hotmart.com/R55076966E?off=55c2y486&checkoutMode=10&_hi=eyJjaWQiOiIxNjQ0NDExOTU2NDMwNjA5NzYzOTA5MDk4NDk1MDAwIiwiYmlkIjoiMTY0NDQxMTk1NjQzMDYwOTc2MzkwOTA5ODQ5NTAwMCIsInNpZCI6IjY3MGZmNWRmZDFhZDRkNjRiNDVjNWFiNTRiYWI0YmViIn0%3D.1647258870908&bid=1647258869076";
  if (await canLaunch(urlBling)) {
    await launch(urlBling);
    print("Deu Certo !");
  } else {
    throw '$urlBling não foi encontrado';
  }
}
