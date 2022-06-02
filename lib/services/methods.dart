import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobiledev/pages/splash_page.dart';


class databaseManager{
  updateUser(String phoneNumber,
      String endereco, String cidade, String name){

    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String uid = _auth.currentUser!.uid;

    return _firestore.collection('usuarios').doc(uid).update(
        {
          "name": name,
          "endereco": endereco,
          "cidade": cidade,
          "phoneNumber": phoneNumber,
        });
  }
}

class checkUpdate{
  updateUser(bool isChecked) {

    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return _firestore.collection('usuarios').doc(_auth.currentUser!.uid).update(
        {
          "isChecked": !isChecked,
        });
  }
}

Future<User?> createAccount(String name, String email, String password,
    String repeatpassword, String phoneNumber, String cidade, String endereco
    ) async {
  FirebaseAuth _auth = FirebaseAuth.instance;


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCrendetial = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print("Conta criada com sucesso");

    userCrendetial.user!.updateDisplayName(name);

    await _firestore.collection('usuarios').doc(_auth.currentUser!.uid).set({
      "name": name,
      "cidade": cidade,
      "endereco": endereco,
      "email": email,
      "phoneNumber": phoneNumber,
      "status": "Unavalible",
      "isAdmin": false,
      "isChecked":true,
      "uid": _auth.currentUser!.uid,
    });

    return userCrendetial.user;
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    print("Login Sucessfull");
    _firestore
        .collection('usuarios')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    return null;
  }
}

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => SplashPage()));
    });
  } catch (e) {
    print("error");
  }
}