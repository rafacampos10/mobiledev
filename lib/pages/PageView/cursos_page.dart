import 'package:flutter/material.dart';
import 'package:mobiledev/pages/PageView/details_curso_30k.dart';
import 'package:mobiledev/pages/PageView/details_curso_alta.dart';
import 'package:mobiledev/pages/PageView/details_curso_bling.dart';
import 'package:mobiledev/pages/PageView/details_curso_mentoria.dart';

class CursosPage extends StatefulWidget {
  const CursosPage({Key? key}) : super(key: key);

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue.shade900,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Curso Bling
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage("images/bling.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              height: 35,
              margin: EdgeInsets.symmetric(horizontal: 10),
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
                      color: Colors.blue.shade900,

                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BlingDetails(),
                        )
                    );
                  },
                ),
              ),
            ), //Curso Bling

            Divider(color: Colors.white,thickness: 2),

            //Curso 30k
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 150,
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
                      color: Colors.blue.shade900,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => trintakDetails(),
                        )
                    );
                  },
                ),
              ),
            ),//Curso 30k

            Divider(color: Colors.white,thickness: 2),

            //Alta Performance
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 150,
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
                      color: Colors.blue.shade900,

                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AltaDetails(),
                        )
                    );
                  },
                ),
              ),
            ),

            Divider(color: Colors.white,thickness: 2),

            //Mentoria
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: 170,
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
              height: 35,
              margin: EdgeInsets.symmetric(horizontal: 10),
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
                      color: Colors.blue.shade900,

                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MentoriaDetails(),
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

