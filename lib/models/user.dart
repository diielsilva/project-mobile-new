import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class User {
  String id;
  String username;
  String password;
  String telephone;
  String state;

  User();

  User.add(this.username, this.telephone, this.password, this.state);

  User.login(this.username, this.password);

  insertUser(User user) async {
    var database = Firestore.instance;
    QuerySnapshot verify = await database
        .collection('users')
        .where('username', isEqualTo: user.username)
        .getDocuments();

    if (verify.documents.isNotEmpty) {
      return Future.value(false);
    } else {
      QuerySnapshot result = await database.collection('users').getDocuments();
      var checkLength = result.documents.length;
      if (this.state == null) {
        this.state = "SP";
      }
      database.collection('users').add({
        'username': user.username,
        'telephone': user.telephone,
        'password': user.password,
        'state': this.state
      });
      QuerySnapshot newResult =
          await database.collection('users').getDocuments();
      var confirmInsert = newResult.documents.length;

      if (confirmInsert > checkLength) {
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    }
  }

  loginUser(String username, String password) async {
    var database = Firestore.instance;
    QuerySnapshot result = await database
        .collection('users')
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .getDocuments();
    return Future.value(result.documents.length);
  }

  editUser(String username, String state, String telephone) async {
    var database = Firestore.instance;
    var result = await database
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();
    result.documents.forEach((item) {
      this.id = item.documentID;
    });
    database.collection('users').document(this.id).updateData({
      "state": state,
      "telephone": telephone,
    });
  }

  detailsUser(String username) async {
    User returnUser = new User();
    var database = Firestore.instance;
    var user = await database
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments();
    user.documents.forEach((item) {
      returnUser.username = item.data['username'];
      returnUser.state = item.data['state'];
      returnUser.telephone = item.data['telephone'];
    });
    return Future.value(returnUser);
  }
}
