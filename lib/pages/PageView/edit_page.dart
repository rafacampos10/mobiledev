import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobiledev/services/methods.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);



  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  final Color azul = Colors.blue.shade900;
  final Color branco = Colors.white;
  final TextEditingController _city = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _endereco = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final fToast = FToast();


  updateData(String phoneNumber,
      String endereco,
      String cidade, String name) async{
    await databaseManager().updateUser(phoneNumber, endereco, cidade, name);
  }

  void didChangeDependencies() async{
    String uid = _auth.currentUser!.uid;
    super.didChangeDependencies();
    await _firestore
        .collection('usuarios')
        .doc(uid)
        .get()
        .then((value) {
      setState(() {
        _name.text = value.data()!['name'];
        _phoneNumber.text = value.data()!['phoneNumber'];
        _city.text = value.data()!['cidade'];
        _endereco.text = value.data()!['endereco'];
      });

    });
  }


  @override
  void initState() {
    super.initState();
    didChangeDependencies();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {

    final _formkey = GlobalKey<FormState>();
    final maskFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
    );
    String uid = _auth.currentUser!.uid;


    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade900,

        actions: [
          Container(
            margin: EdgeInsets.only(left: 135, right: 165, top: 5),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                      "images/aplicativo.png",
                      color: azul,
                      height: 40,
                      width: 35),
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: azul,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('usuarios').doc(uid).snapshots(),
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                      ),
                      controller: _name,
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'Insira seu nome completo';
                        } if(!RegExp("^[a-zA-ZéúíóáÉÚÍÓÁèùìòàÈÙÌÒÀõãñÕÃÑêûîôâÊÛÎÔÂëÿüïöäËYÜÏÖÄçÇ.'-]{4,}"
                            "(?: [a-zA-ZéúíóáÉÚÍÓÁèùìòàÈÙÌÒÀõãñÕÃÑêûîôâÊÛÎÔÂëÿüïöäËYÜÏÖÄçÇ"
                            ".'-]+){2,}").hasMatch(value)){
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
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _phoneNumber,
                      keyboardType: TextInputType.phone,
                      validator: (value){
                        if(value!.isEmpty || value == null)
                        {
                          return 'Digite seu telefone';
                        }
                        if(value.length< 14){
                          return 'Telefone invalido';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Telefone:",
                        labelStyle: TextStyle(
                          color: branco,
                        ),
                        suffixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: branco,
                      ),
                      inputFormatters: [maskFormatter],
                    ),
                    TextFormField(
                      controller: _city,
                      keyboardType: TextInputType.name,
                      validator:(value){
                        if(value!.isEmpty || value == null)
                        {
                          return 'Digite sua cidade';
                        }if(value.length <= 2){
                          return 'Cidade não existe';
                        } if(value.length > 32){
                          return 'Tamanho excedeu. Digite sua cidade';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Cidade + Estado:",
                        hintText: "Sua cidade - Seu estado",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        labelStyle: TextStyle(
                          color: branco,
                        ),
                        suffixIcon: Icon(
                          Icons.location_on,
                          color: Colors.white,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: branco,
                      ),
                    ),
                    TextFormField(
                      controller: _endereco,
                      keyboardType: TextInputType.streetAddress,
                      validator:(value){
                        if(value!.isEmpty || value == null)
                        {
                          return 'Digite seu endereço';
                        } if(value.length <= 2){
                          return 'Endereço inexistente';
                        }if(value.length > 50){
                          return 'Tamanho excedeu. Digite seu endereço';
                        }
                        return null;
                      },

                      decoration: InputDecoration(labelText: "Endereço:",
                        labelStyle: TextStyle(
                          color: branco,
                        ),
                        suffixIcon: Icon(
                          Icons.apartment,
                          color: Colors.white,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 20,
                        color: branco,
                      ),
                    ),
                    SizedBox(
                      height: 30,
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
                            "Salvar",
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: (){
                            if(_formkey.currentState!.validate()) {
                              setState(() {
                                submitAction(context);
                                Navigator.pop(context);
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          } else if(snapshot.hasError){
            const Text ("Houve um erro, tente novamente");
          }
          return Center(
            child: CircularProgressIndicator(color: branco),
          );
          },
      )

    );
  }

  submitAction(BuildContext context) {
      if (_phoneNumber.text.isNotEmpty &&
          _endereco.text.isNotEmpty &&
          _city.text.isNotEmpty && _name.text.isNotEmpty) {
        updateData(_phoneNumber.text,
            _endereco.text, _city.text, _name.text);
        fToast.showToast(
          child: buildToast(),
          toastDuration: Duration(seconds: 2),
          gravity: ToastGravity.BOTTOM,
        );
      }
      _phoneNumber.clear();
      _city.clear();
      _endereco.clear();
      _name.clear();
    }
  }

  Widget buildToast() => Container(
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
        Text("Alteração realizado com sucesso",style: TextStyle(color: Colors.white),),
      ],
    ),
  );
