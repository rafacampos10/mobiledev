import 'package:flutter/material.dart';
import 'package:mobiledev/pages/login.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(0,76,63,1),
      padding: const EdgeInsets.only(top: 250.0),
      child: Column(children: [
        Image.asset(
          "images/umobile-horizontal.jpg",
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Center(
                  child: Text(
                "A sua forma de interação jamais vista",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                ),
              )),
            )
          ],
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Container(
            height: 200,
            width: 350,
            child: Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    fixedSize: Size(330, 40),
                    side: BorderSide(color: Color.fromRGBO(0,76,63,1), width: 2),
                    backgroundColor: Colors.white),
                onPressed: () {
                  //o pushNamed só colocar o nome da rota
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                child: Text("Acessar DevMobile",
                    style: TextStyle(fontSize: 18, color: Color.fromRGBO(0,76,63,1))),
              ),
            ),
          )
        ])
      ]),
    );
  }
}
