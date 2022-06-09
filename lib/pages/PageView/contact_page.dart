import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class contactPage extends StatefulWidget {
  const contactPage({Key? key}) : super(key: key);

  @override
  State<contactPage> createState() => _contactPageState();
}

class _contactPageState extends State<contactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0,76,63,1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 200),
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          child:  Column(
              children: [
                Text("Contatos do Ultimate Mobile LTDA",style: TextStyle(fontSize: 20,color: Colors.white)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                          onPressed: _abrirWhatsApp,
                          icon: Image.asset('images/whatsapp.png',height: 50,width: 50,fit: BoxFit.cover,)),
                      IconButton(
                          onPressed: _linkedin,
                          icon: Image.asset('images/linkedin.png',height: 50,width: 50,fit: BoxFit.cover)),
                      IconButton(
                          onPressed: _instagram,
                          icon: Image.asset('images/instagram.png',height: 50,width: 50,fit: BoxFit.cover)),
                      IconButton(
                          onPressed: _abrirGmail,
                          icon: Image.asset('images/gmail.png',height: 50,width: 50,fit: BoxFit.cover))
                    ],
                  ),

                )
              ]
          ),
        ),
      ),
    );
  }
}

_linkedin() async{
  const url = "https://www.linkedin.com/in/rafael-campos-martins-72a802159";
  if (await canLaunch(url)){
    await launch(url);
    print("Realizado com sucesso !");
  } else{
    throw "$url não encontrado";
  }
}
_instagram() async{
  const url = "https://www.instagram.com/rafacampos94/";
  if (await canLaunch(url)){
    await launch(url);
    print("Realizado com sucesso !");
  } else{
    throw "$url não encontrado";
  }
}
_abrirGmail() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: 'rcmartins.1894@gmail.com',
    query: 'subject=Reportar&body= ',
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    print('Could not launch $url');
  }
}
_abrirWhatsApp() async {
  var whatsappUrl = "whatsapp://send?phone=+5519991228430&text=Olá,tudo bem ?";

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}
