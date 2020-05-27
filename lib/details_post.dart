import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'models/user.dart';

class DetailsPost extends StatefulWidget {
  String idPost;
  String title = "Carregando...";
  String description = "Carregando...";
  String image = "Carregando...";
  String breed = "Carregando...";
  String postedBy = "Carregando...";
  User user;

  @override
  DetailsPost(param, param2, param3, param4, param5, param6, User param7) {
    this.idPost = param;
    this.title = param2;
    this.description = param3;
    this.image = param4;
    this.breed = param5;
    this.postedBy = param6;
    this.user = param7;
  }

  _DetailsPostState createState() => _DetailsPostState(this.idPost, this.title,
      this.description, this.image, this.breed, this.postedBy, this.user);
}

class _DetailsPostState extends State<DetailsPost> {
  String idPost;
  String title = "Carregando...";
  String description = "Carregando...";
  String image = "Carregando...";
  String breed = "Carregando...";
  String postedBy = "Carregando...";
  String telephone = "Carregando...";
  String state = "Carregando...";
  User user;

  @override
  _DetailsPostState(
      param, param2, param3, param4, param5, param6, User param7) {
    this.idPost = param;
    this.title = param2;
    this.description = param3;
    this.image = param4;
    this.breed = param5;
    this.postedBy = param6;
    this.user = param7;
  }

  Widget build(BuildContext context) {
    setState(() {
      this.telephone = user.telephone;
      this.state = user.state;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes da Publicação"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                ClipRRect(child: Image.network(this.image, height: 400), borderRadius: BorderRadius.circular(15),),
                Divider(
                  color: Colors.transparent,
                ),
                Divider(color: Colors.transparent,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Titulo: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
                    Text("${this.title}",style: TextStyle(fontSize: 20),)
                  ],
                ),
                Divider(color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Raça: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
                    Text("${this.breed}",style: TextStyle(fontSize: 20),)
                  ],
                ),
                Divider(color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Descrição: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
                    Text("${this.description}",style: TextStyle(fontSize: 20),)
                  ],
                ),
                Divider(color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Postado Por: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
                    Text("${this.user.username}",style: TextStyle(fontSize: 20),)
                  ],
                ),
                Divider(color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Telefone: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
                    Text("${this.telephone}",style: TextStyle(fontSize: 20),)
                  ],
                ),
                Divider(color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Estado: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),),
                    Text("${this.state}",style: TextStyle(fontSize: 20),)
                  ],
                ),
                Divider(color: Colors.blue,),
              ],
            ),
          ),
        ),
      )
    );
  }
}
