import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype/details_post.dart';
import 'package:prototype/models/user.dart';
import 'package:prototype/my_posts.dart';
import 'package:prototype/perfil.dart';
import 'insert.dart';

class Menu extends StatefulWidget {
  String _user;

  @override
  _MenuState createState() => _MenuState(this._user);

  Menu(param) {
    this._user = param;
  }
}

class _MenuState extends State<Menu> {
  _MenuState(param) {
    this.user = param;
  }

  var states = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PE',
    'PI',
    'PR',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

  String user;
  String currentState;
  var operation = Firestore.instance
      .collection('posts')
      .orderBy('date', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem-Vindo"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  "Menu de Opções",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                decoration: BoxDecoration(color: Colors.green),
              ),
            ),
            ListTile(
              title: Text("Inserir Publicação"),
              trailing: Icon(Icons.add, color: Colors.green,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Insert(this.user);
                }));
              },
            ),
            ListTile(
              title: Text('Minhas Publicações'),
              trailing: Icon(Icons.assignment,color: Colors.green,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyPosts(this.user);
                }));
              },
            ),
            ListTile(
              title: Text('Meu Perfil'),
              trailing: Icon(Icons.account_circle, color: Colors.green,),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MyPerfil(this.user);
                }));
              },
            ),
            ListTile(
              title: Text("Sair"),
              trailing: Icon(Icons.power_settings_new, color: Colors.red,),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Divider(color: Colors.transparent,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DropdownButton(
                hint: Text(
                  "Filtrar por estado",
                ),
                items: states.map((String dropDownItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownItem,
                    child: Text(dropDownItem),
                  );
                }).toList(),
                onChanged: (String item) {
                  setState(() {
                    this.currentState = item;
                    print(currentState);
                  });
                },
                value: this.currentState,
              ),
              IconButton(
                icon: Icon(Icons.format_list_bulleted, color: Colors.green, size: 40,),
                  onPressed: () {
                    setState(() {
                      this.operation = Firestore.instance
                          .collection('posts')
                          .where('state', isEqualTo: this.currentState)
                          .snapshots();
                    });
                  }
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Divider(
            color: Colors.green,
          ),
          Expanded(
            child: StreamBuilder(
              stream: operation,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(documents[index].data['title']),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(documents[index].data['urlImage']),
                          ),
                          subtitle: Text(documents[index].data['description']),
                          onTap: () async{
                            User user = new User();
                            user = await user.detailsUser(documents[index].data['postedBy']);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailsPost(
                                  documents[index].documentID,
                                  documents[index].data['title'],
                                  documents[index].data['description'],
                                  documents[index].data['urlImage'],
                                  documents[index].data['breed'],
                                  documents[index].data['postedBy'],
                                  user);
                            }));
                          },
                        );
                      },
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
