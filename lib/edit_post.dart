import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/post.dart';

class EditPost extends StatefulWidget {
  String idPost;
  var imageWeb;

  EditPost(param, param2) {
    this.idPost = param;
    this.imageWeb = param2;
  }

  @override
  _EditPostState createState() => _EditPostState(this.idPost, this.imageWeb);
}

class _EditPostState extends State<EditPost> {
  var imageWeb;
  String idPost;
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _breedController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  File _image;

  Future getImageCamera() async {
    if (_image == null) {
      _image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      return;
    }
  }

  Future getImageGallery() async {
    if (_image == null) {
      _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    } else {
      return;
    }
  }

  _EditPostState(param, param2) {
    this.idPost = param;
    this.imageWeb = param2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Editar Publicação"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.content_paste,
                      size: 100,
                      color: Colors.green,
                    ),
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.border_color, color: Colors.green),
                        hintText: "Título",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Preencha todos os campos corretamente";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _breedController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.pets, color: Colors.green),
                        hintText: "Raça",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Preencha todos os campos corretamente";
                        }
                      },
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.description,
                          color: Colors.green,
                        ),
                        hintText: "Descrição",
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.green,
                              ),
                              onPressed: () async {
                                getImageCamera();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.green,
                              ),
                              onPressed: () async {
                                getImageGallery();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.check, color: Colors.green,),
                      iconSize: 40,
                        onPressed: () async {
                          if (_key.currentState.validate()) {
                            if(this.imageWeb == ""){
                              this.imageWeb = "nulo";
                            }
                            Post post = new Post();
                            await post.editPost(
                                this.idPost,
                                this.imageWeb,
                                this._image,
                                this._titleController.text,
                                this._breedController.text,
                                this._descriptionController.text);
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
