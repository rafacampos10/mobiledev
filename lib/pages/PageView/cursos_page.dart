import 'package:flutter/material.dart';
import 'package:mobiledev/pages/PageView/details-auto.dart';
import 'package:mobiledev/pages/PageView/details-client.dart';
import 'package:mobiledev/pages/PageView/details-uniapp.dart';

class CursosPage extends StatefulWidget {
  const CursosPage({Key? key}) : super(key: key);

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 76, 63, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Veiculo autonomo
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/auto-banner-atualizado.jpg",
                    width: 340,
                  ),
                ],
              ),
            ),
            Text("Veiculo Autônomo",style: TextStyle(color: Colors.white)),
            Container(
              height: 35,
              margin: EdgeInsets.symmetric(horizontal: 70,vertical: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),

              child: SizedBox.expand(
                child: TextButton(
                  child: Text(
                    "Ver Mais",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 76, 63, 1),

                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => autoDetails(),
                        )
                    );
                  },
                ),
              ),
            ), //Curso Bling

            Divider(color: Colors.white,thickness: 2),

            //Web Client-Service
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: Row(
                children: [
                 Image.asset(
                "images/service-banner-atualizado.jpg",
                width: 340,
              ),
                ],
              ),
            ),
            Text("Web Client-Service",style: TextStyle(color: Colors.white)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70,vertical: 10),
              height: 35,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: SizedBox.expand(
                child: TextButton(
                  child: Text(
                    "Ver Mais",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 76, 63, 1),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => clientDetails(),
                        )
                    );
                  },
                ),
              ),
            ),//Curso 30k

            Divider(color: Colors.white,thickness: 2),

            //UniApp
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: Row(
                children: [
                  Image.asset(
                    "images/uniapp-banner-atualizado.jpg",
                    width: 340,
                  ),
                ],
              ),
            ),
            Text("Aplicativo UniApp",style: TextStyle(color: Colors.white)),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 70,vertical: 10),
              height: 35,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),

              child: SizedBox.expand(
                child: TextButton(
                  child: Text(
                    "Ver Mais",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 76, 63, 1),

                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => uniappDetails(),
                        )
                    );
                  },
                ),
              ),
            ),
            Divider(color: Colors.white,thickness: 2),
          ],
        ),
      ),
    );
  }
}

