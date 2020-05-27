import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype/edit_perfil.dart';
import 'models/user.dart';

class MyPerfil extends StatefulWidget {
  String user;

  @override
  MyPerfil(param) {
    this.user = param;
  }

  _MyPerfilState createState() => _MyPerfilState(this.user);
}

class _MyPerfilState extends State<MyPerfil> {
  _MyPerfilState(param) {
    this.user = param;
  }

  String user;
  User infoUser = new User();

  void getUser() async {
    infoUser = await infoUser.detailsUser(this.user);
    setState(() {
      this.username = infoUser.username;
      this.telephone = infoUser.telephone;
      this.state = infoUser.state;
    });
  }
  String username = "Carregando...";
  String telephone = "Carregando...";
  String state = "Carregando...";
  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Perfil'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Icon(
                  Icons.account_circle,
                  color: Colors.green,
                  size: 100,
                ),
              ),
              Divider(color: Colors.transparent),
              Row(
                children: <Widget>[
                  Text(
                    "Usuário: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${this.username}",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Divider(color: Colors.grey,),
              Row(
                children: <Widget>[
                  Text(
                    "Telefone: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${this.telephone}",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Divider(color: Colors.grey),
              Row(
                children: <Widget>[
                  Text(
                    "Estado: ",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 20,color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${this.state}",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              Divider(color: Colors.grey,),
              Divider(color: Colors.transparent),
              Divider(color: Colors.transparent),
              Center(
                child: IconButton(
                    icon: Icon(Icons.edit,size: 40,),
                    color: Colors.green,
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return EditPerfil(this.user);
                      }));
                    }
                ),
              ),
            ],
          ),

      ),
    );
  }
}
