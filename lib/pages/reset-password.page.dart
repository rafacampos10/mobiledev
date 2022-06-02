import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  final fToast = FToast();

  @override
  void initState() {
    super.initState();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Colors.blue.shade900,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset("images/logo-login.png"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Esqueceu sua senha?",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Por favor, informe o e-mail associado a sua conta que "
                            "enviaremos um link para o mesmo com as instruções "
                            "para restauração de sua senha.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formkey,
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value){
                              if(!RegExp("^[a-z0-9+_.-]+@[a-z0-9.-]+.[a-z]").hasMatch(value!)){
                                return 'Escreva um email válido';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                      ),

                      SizedBox(
                        height: 20,
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
                              "Recuperar a Senha",
                              style: TextStyle(
                                color: Colors.blue.shade900,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  isLoading = false;
                                });
                                fToast.showToast(
                                  child: buildToast(),
                                  toastDuration: Duration(seconds: 6),
                                  gravity: ToastGravity.BOTTOM,
                                );
                                FirebaseAuth.instance
                                    .sendPasswordResetEmail(email: _email.text)
                                    .then((value) =>
                                    Navigator.of(context).pop());
                              }
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
  Widget buildToast() => Container(
    width: MediaQuery.of(context).size.width/1.2,
    height: MediaQuery.of(context).size.height/10,
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.green.shade900,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check,color: Colors.white),
        SizedBox(
          width: 10,
        ),
        Text("Solicitação enviada. Em breve você receberá \n um e-mail com link de redefinição de senha",style: TextStyle(color: Colors.white)
        ),
      ],
    ),
  );
}