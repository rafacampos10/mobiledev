import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobiledev/pages/home_page.dart';
import 'package:mobiledev/services/methods.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _cidade = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repeatpassword = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final fToast = FToast();
  bool isLoading = false;
  final maskFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(color: Colors.white),
        ),
      )
          : SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Container(
                margin: EdgeInsets.only(top: 90),
                alignment: Alignment.center,
                width: size.width / 1.1,
                child: Text(
                  "Bem vindo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width / 1.1,
                child: Text(
                  "Crie sua conta",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: size.width,
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller:_name,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Insira seu nome completo';
                    } if(!RegExp("^[a-zA-ZéúíóáÉÚÍÓÁèùìòàÈÙÌÒÀõãñÕÃÑêûîôâÊÛÎÔÂëÿüïöäËYÜÏÖÄçÇ"
                          ".'-]{4,}"
                          "(?: [a-zA-ZéúíóáÉÚÍÓÁèùìòàÈÙÌÒÀõãñÕÃÑêûîôâÊÛÎÔÂëÿüïöäËYÜÏÖÄçÇ"
                          ".'-]+){1,}").hasMatch(value)){
                        return 'Insira um nome válido';
                      }
                      },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.account_box,
                        color: Colors.white,
                      ),
                      labelText:"Nome Completo:",
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: size.width,
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller:_endereco,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Insira seu endereço completo';
                    } if(value.length<=7){
                        return 'Insira um endereço válido';
                      }
                      },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.apartment,
                        color: Colors.white,
                      ),
                      labelText:"Endereço:",
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: size.width,
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller:_cidade,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Insira sua cidade';
                    } if(value.length<=4){
                        return 'Insira uma cidade válida';
                      }
                      },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      labelText:"Cidade:",
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child:Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: size.width,
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _email,
                    validator: (value){
                      if(value!.isEmpty || value == null)
                      {
                        return 'Escreva seu email';
                      }
                      if(!RegExp("^[a-z0-9+_.-]+@[a-z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Escreva um email válido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "seuemail@email.com",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                      labelText: "Email:",
                      labelStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white),
                      suffixIcon: Icon(
                          Icons.email,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: size.width/1.1,
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _password,
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Digite novamente a senha';
                    }
                         if (value.length < 6) {
                          return "Senha precisa de no mínimo 6 caracteres";
                        }
                          return null;
                        },
                    decoration: InputDecoration(
                      labelText: "Senha:",
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: size.width/1.1,
                  alignment: Alignment.center,
                  child: TextFormField(
                    validator: (value){
                      if (value == null || value.isEmpty) {
                        return 'Digite novamente a senha';
                      }

                      if (value != _password.text) {
                        return 'A senha não confere';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    controller: _repeatpassword,
                    decoration: InputDecoration(
                      labelText: "Repetir senha:",
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.white,
                      ),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  width: size.width,
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    controller: _phoneNumber,
                    validator: (value){
                      if(value!.isEmpty || value == null)
                      {
                        return 'Escreva seu telefone';
                      }
                      if(value.length< 14){
                        return 'Telefone invalido';
                      }
                      return null;
                    },
                    inputFormatters: [maskFormatter],
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.phone,color: Colors.white),
                      hintText: "(DD) XXXXX-XXXX",
                      labelText:"Telefone:",
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              customButton(size),
              Padding(
                padding: const EdgeInsets.all(35.0),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(330,40),
                      side: BorderSide(color: Colors.white, width: 2)
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Já tenho uma conta",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if(_formkey.currentState!.validate()) {
          setState(() {
            isLoading = false;
          });
          createAccount(_name.text, _email.text, _password.text, _repeatpassword.text,
              _phoneNumber.text,_cidade.text, _endereco.text).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              fToast.showToast(
                child: buildDeuCerto(),
                toastDuration: Duration(seconds: 4),
                gravity: ToastGravity.BOTTOM,
              );
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
        }else{
              fToast.showToast(
                child: buildDeuErrado(),
                toastDuration: Duration(seconds: 4),
                gravity: ToastGravity.BOTTOM,
              );
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CreateAccount()));
        }
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
            "Criar conta",
            style: TextStyle(
              color: Colors.blue.shade900,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        style: TextStyle(color: Colors.white),
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildDeuCerto() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.green.shade900,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.check,color: Colors.white),
        SizedBox(
          width: 12.0,
        ),
        Text("Conta criada com sucesso",style: TextStyle(color: Colors.white),),
      ],
    ),
  );

  Widget buildDeuErrado() => Container(
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
        Text("Email já cadastrado no UniApp",style: TextStyle(color: Colors.white),),
      ],
    ),
  );
}