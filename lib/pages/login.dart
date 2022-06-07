import 'package:flutter/material.dart';
import 'package:mobiledev/pages/PageView/create_account.dart';
import 'package:mobiledev/pages/home_page.dart';
import 'package:mobiledev/pages/reset-password.page.dart';
import 'package:mobiledev/services/methods.dart';
import 'package:mobiledev/services/prefs_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;
  final fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(0,76,63,1),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(270),
        child:Column(
          children: [
            Container(
                color: Color.fromRGBO(0,76,63,1),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: SizedBox(
                        child: Image.asset("images/umobile-horizontal.jpg", height: 210, width: 210,),
                      ),
                    )

                  ],
                )
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(color: Colors.white),
        ),
      )
          : SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 200,
            ),
            Container(
              alignment: Alignment.center,
              width: size.width / 1.1,
              child: Text(
                "Bem Vindo ao DevMobile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              width: size.width,
              alignment: Alignment.center,
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: _email,
                decoration: InputDecoration(labelText: "Email:",
                  suffixIcon: Icon(Icons.account_box,color: Colors.white),
                  labelStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
            ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: size.width/1.1,
                alignment: Alignment.center,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  controller: _password,
                  decoration: InputDecoration(labelText: "Senha:",
                    suffixIcon: Icon(Icons.lock,color: Colors.white),
                    labelStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  obscureText: true,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ResetPasswordPage())),
              child: Text(
                "Esqueceu a senha",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            customButton(size),
            SizedBox(
              height: size.height / 40,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => CreateAccount())),
              child: Text(
                "Cria a sua Conta",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = false;
          });

          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              var prefs = new PrefsService();
              prefs.save(user);
              setState(() {
                isLoading = true;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            } else {
              // Custom Toast Position
              fToast.showToast(
                  child: buildToast(),
                  toastDuration: Duration(seconds: 2),
                gravity: ToastGravity.BOTTOM,
                  );
              setState(() {
                isLoading = false;
              });
            }
          });
        }
        if(_email.text.isEmpty || _password.text.isEmpty){
          setState(() {
            isLoading = false;
          });
          fToast.showToast(
            child: buildComplete(),
            toastDuration: Duration(seconds: 2),
            gravity: ToastGravity.BOTTOM,
          );
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Text(
            "Login",
            style: TextStyle(
              color: Color.fromRGBO(0,76,63,1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

    Widget buildToast() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red.shade900,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close,color: Colors.white),
          SizedBox(
            width: 12.0,
          ),
          Text("e-mail e/ou senha incorreta",style: TextStyle(color: Colors.white),),
        ],
      ),
    );

  Widget buildComplete() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.red.shade900,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.close,color: Colors.white),
        SizedBox(
          width: 12.0,
        ),
        Text("e-mail e/ou senha incorreta",style: TextStyle(color: Colors.white),),
      ],
    ),
  );
}