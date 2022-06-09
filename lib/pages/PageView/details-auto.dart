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

      backgroundColor: Color.fromRGBO(0,76,63,1),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Curso Bling
            Container(
              margin: EdgeInsets.symmetric(horizontal: 35),
              width: MediaQuery.of(context).size.width,
              height: 300,
        child: Row(
            children: [
                Image.asset("images/auto-banner-atualizado.jpg",width: 320),
        ]
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "O projeto de Veículo Autônomo é um projeto de TCC de Engenharia"
                    " da Computação da universidade UniMetrocamp.\n"
                    "O veículo se desloca em ambiente desestruturado, fazendo "
                    "movimentações autônomas, se dirigindo autonomamente de um "
                    "ponto a outro do ambiente. O veículo utiliza sensores do "
                    "tipo ultrassônicos para medir a distância de possíveis obstáculos, "
                    "podendo desviar-se dos mesmos de forma autônoma, evitando "
                    "assim colisões.\n"
                    " Para a implementação do software utilizou-se a plataforma "
                    "computacional embarcada do tipo Arduino. Foram testados "
                    "diferentes algoritmos para a identificação e desvio de obstáculos.\n"
                    " Cada um dos procedimentos de aprendizagem mostra um diferente"
                    " tipo de mecanismo evolutivo. Experimentos de simulação "
                    "mostraram que o sistema de desvio de obstáculos é capaz de "
                    "aprender estratégias de navegações em ambientes "
                    "desconhecidos, com reduzido custo e tempo computacional.",
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