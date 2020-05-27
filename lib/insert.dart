import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prototype/models/post.dart';
import 'dart:io';
import 'models/user.dart';

class Insert extends StatefulWidget {
  String _userPost;

  @override
  _InsertState createState() => _InsertState(this._userPost);

  Insert(param) {
    this._userPost = param;
  }
}

class _InsertState extends State<Insert> {
  _InsertState(param) {
    this.userPost = param;
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userPost;
  File _image;
  String _imageAux;
  var result;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _breedController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

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

  void refresh(){
    setState(() {
      _image = null;
      _breedController.text = '';
      _titleController.text = '';
      _descriptionController.text = '';
      _formKey = new GlobalKey<FormState>();
    });
  }

  void reset() async{
    if(this.result == null){
      return;
    }
    else{
      setState(() {
        _image = null;
        _breedController.text = '';
        _titleController.text = '';
        _descriptionController.text = '';
        _formKey = new GlobalKey<FormState>();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inserir Publicação"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              refresh();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  color: Colors.green,
                  size: 100,
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                      hintText: 'Título',
                      icon: Icon(
                        Icons.border_color,
                        color: Colors.green,
                      )),
                  validator: (value) {
                    if (value.isEmpty)
                      return "Preencha todos os campos corretamente";
                  },
                ),
                TextFormField(
                  controller: _breedController,
                  decoration: InputDecoration(
                    hintText: "Raça",
                    icon: Icon(
                      Icons.pets,
                      color: Colors.green,
                    ),
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
                    hintText: "Descrição",
                    icon: Icon(
                      Icons.description,
                      color: Colors.green,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha todos os campos corretamente";
                    }
                  },
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
                Container(
                  margin: EdgeInsets.all(15),
                  child: Center(
                    child: IconButton(
                      icon: Icon(Icons.check, color: Colors.green, size: 40,),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var post = new Post.add(
                                _titleController.text,
                                _breedController.text,
                                _descriptionController.text,
                                this.userPost);
                            this.result = await post.insertPost(
                                this.userPost, post, this._image);
                            reset();
                            if (this.result == true) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Post Cadastrado',
                                          style: TextStyle(color: Colors.green)),
                                      content:
                                      Text('Post cadastrado com sucesso'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Confirmar',
                                              style:
                                              TextStyle(color: Colors.blue)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Erro ao Postar',
                                          style: TextStyle(color: Colors.red)),
                                      content: Text(
                                          'Erro ao postar, verifique sua conexão e tente novamente'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Confirmar',
                                              style:
                                              TextStyle(color: Colors.blue)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }
                          }
                        }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
