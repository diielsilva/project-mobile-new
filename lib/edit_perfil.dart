import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import 'models/user.dart';

class EditPerfil extends StatefulWidget {
  EditPerfil(param) {
    this.user = param;
  }

  String user;

  @override
  _EditPerfilState createState() => _EditPerfilState(this.user);
}

class _EditPerfilState extends State<EditPerfil> {
  _EditPerfilState(param) {
    this.user = param;
  }

  String user;
  TextEditingController _telephoneController = new TextEditingController();
  GlobalKey<FormState> _keyForm = new GlobalKey<FormState>();
  String currentState;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Perfil"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.assignment,
                  size: 100,
                  color: Colors.green,
                ),
                TextFormField(
                  controller: _telephoneController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.call, color: Colors.green),
                    hintText: "Telefone",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Preencha todos os campos corretamente";
                    }
                  },
                ),
                Divider(color: Colors.transparent),
                DropdownButton(
                  hint: Text(
                    "Selecione seu estado",
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
                Divider(color: Colors.transparent,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Nota: ",style: TextStyle(color: Colors.green,fontSize: 20)),
                      Text("Estado padrão SP",style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
                Divider(color: Colors.transparent,),
                IconButton(
                  icon: Icon(Icons.check, color: Colors.green,),
                  iconSize: 40,
                    onPressed: () async {
                      if (_keyForm.currentState.validate()) {
                        User edit = new User();
                        if (currentState == null) {
                          currentState = "SP";
                        }
                        var result = await edit.editUser(this.user,
                            this.currentState, _telephoneController.text);
                        Navigator.pop(context);
                      }
                    },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
