import 'package:flutter/material.dart';
import 'package:mobiledev/pages/login.dart';


class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade900,

      padding: const EdgeInsets.only(top: 120.0),
      child: Column(
        children: [
          Image.asset(
            "images/logo-login.png",
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Center(
                  child: Text(
                    "Tenha o DOMÍNIO do seu negócio na palma de suas mãos",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    ),

                  )
                ),
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
                  child: ElevatedButton(
                    onPressed: (){
                      //o pushNamed só colocar o nome da rota
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen(),
    )
    );

                    },
                    child: Text("Acessar UniApp",style: TextStyle(fontSize: 18)),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width,35)
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],

      ),
    );
  }
}
