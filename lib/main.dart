import 'package:flutter/material.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() async{

  runApp(MaterialApp(
    title: "Aplicação de Testes",
    home: Login(),
  ));

}