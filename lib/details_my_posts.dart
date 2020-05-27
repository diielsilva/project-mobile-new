import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype/edit_post.dart';

import 'models/post.dart';

class DetailsMyPost extends StatefulWidget {
  String title;
  String breed;
  String image;
  String description;
  String id;

  DetailsMyPost(param,param2,param3,param4,param5){
    this.title = param;
    this.breed = param2;
    this.image = param3;
    this.description = param4;
    this.id = param5;
  }
  @override
  _DetailsMyPostState createState() => _DetailsMyPostState(this.title,this.breed,this.image,this.description,this.id);
}

class _DetailsMyPostState extends State<DetailsMyPost> {
  String title;
  String breed;
  String image;
  String description;
  String id;

  _DetailsMyPostState(param,param2,param3,param4,param5){
    this.title = param;
    this.breed = param2;
    this.image = param3;
    this.description = param4;
    this.id = param5;
  }

  @override
  Widget build(BuildContext context) {
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
                Divider(color: Colors.transparent,),
                Divider(color: Colors.transparent,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Titulo: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    Text("${this.title}", style: TextStyle(fontSize: 20),)
                  ],
                ),
                Divider(color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Raça: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                    Text("${this.breed}", style: TextStyle(fontSize: 20)),
                  ],
                ),
                Divider(color: Colors.grey,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Descrição: ", style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      Text("${this.description}", style: TextStyle(fontSize: 20)),
                    ]
                ),
                Divider(color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete,size: 40,),
                      color: Colors.green,
                      onPressed: () async{
                        Post post = new Post();
                        await post.deletePost(this.id, this.image);
                        Navigator.pop(context);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit,size: 40,),
                      color: Colors.green,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return EditPost(this.id, this.image);
                        }));
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
