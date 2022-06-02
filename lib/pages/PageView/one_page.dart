import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnePage extends StatefulWidget {
  const OnePage({Key? key}) : super(key: key);

  @override
  State<OnePage> createState() => _OnePageState();


}

class _OnePageState extends State<OnePage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CarouselSlider(
                  items: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/logo-login.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ), //Imagem 0

                    Container(
                      margin: EdgeInsets.symmetric(vertical:32,horizontal: 5),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "images/30k-banner.png",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),//Imagem 1

                    Container(
                      margin: EdgeInsets.only(top: 59,left: 20,right: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "images/altaperformance-banner.png",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage("images/bling.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),//Imagem 3

                    Container(
                      margin: EdgeInsets.only(top: 48.5,left: 20,right: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                                "images/mentoria-banner-atualizado.png",
                            ),
                          ],
                        ),
                      ),
                    ),//Imagem 4

                  ],
                    options:
                CarouselOptions(
                  height: 200.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 600),
                  viewportFraction: 0.8,
                ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 162),
                  child: Center(
                    child: Text(
                      "Cursos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("images/bling.png", width: 80),
                  Image.asset(
                    "images/30k.png",
                    width: 80,
                    color: Colors.white,
                  ),
                  Image.asset(
                    "images/altaperformance.png",
                    width: 80,
                    color: Colors.white,
                  ),
                  Image.asset(
                    "images/mentoria.png",
                    width: 80,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 160),
                  child: Center(
                    child: Text(
                      "Eventos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("images/logo-login.png", width: 100),
                  Image.asset("images/logo-login.png", width: 100),
                  Image.asset("images/logo-login.png", width: 100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

