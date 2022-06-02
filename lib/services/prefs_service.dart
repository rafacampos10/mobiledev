import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService{

  static final String _key = "key";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  save(dynamic user) async{
    await _firestore
        .collection('usuarios')
        .where("uid", isEqualTo: user.uid)
        .get()
        .then((value) async {
      var userMap = value.docs[0].data();
        var prefs = await SharedPreferences.getInstance();
      prefs.setString(_key, jsonEncode({
        "name": userMap['name'],
        "isAuth": true,
        "isAdmin": userMap['isAdmin'],
        "email": userMap['email'],
        "isChecked": userMap['isChecked'],
        "endereco": userMap['endereco'],
      "cidade": userMap['cidade'],
      "phoneNumber": userMap['phoneNumber']}));
    });

  }

  static Future<bool> isAuth() async{
    var prefs = await SharedPreferences.getInstance();
    
    var jsonResult = prefs.getString(_key);

    if(jsonResult != null){
      var mapUser = jsonDecode(jsonDecode(jsonResult));
      return mapUser("isAuth");

      
    }
    
    return false;
  }

  static Future auth() async{
    var prefs = await SharedPreferences.getInstance();

    var jsonResult = prefs.getString(_key);

    if(jsonResult != null){
      Map<String, dynamic> user = jsonDecode(jsonResult);
      return user;
    }

    return null;
  }

  static logout() async{
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);

  }
}