import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mobiledev/pages/PageView/details-auto.dart';
import 'package:mobiledev/pages/PageView/details-client.dart';
import 'package:mobiledev/pages/PageView/details-uniapp.dart';

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
      backgroundColor: Color.fromRGBO(0, 76, 63, 1),
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
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/umobile-horizontal.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ), //Imagem 1

                    Container(
                      margin: EdgeInsets.only(top: 59, left: 20, right: 20),
                      child: Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "images/aplicativo.png",
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
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
                  margin: EdgeInsets.symmetric(horizontal: 100),
                  child: Center(
                    child: Text(
                      "Projetos Realizados",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => uniappDetails()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color.fromRGBO(125, 213, 87, 1),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/uniapp.png',
                              width: 150,
                              height: 150,
                            ),
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 60),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("UniApp",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                      ])),
                            ),
                          ]))),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => clientDetails()));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color.fromRGBO(125, 213, 87, 1),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/service.jpg',
                              width: 150,
                              height: 150,
                            ),
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 60),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Client-Server",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                      ])),
                            ),
                          ]))),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => autoDetails()));
              },
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  color: Color.fromRGBO(125, 213, 87, 1),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/logo-login.png',
                              width: 150,
                              height: 150,
                            ),
                            Expanded(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 60),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Veículo Autônomo",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white)),
                                      ])),
                            ),
                          ]
                      )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
