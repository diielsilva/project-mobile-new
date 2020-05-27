import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/user.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
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
  String currentState;
  var result;

  @override
  void reset() async {
    if (this.result == null) {
      return;
    } else if (this.result == true) {
      setState(() {
        _userController.text = '';
        _passController.text = '';
        _confirmPassController.text = '';
        _telephoneController.text = '';
        _keyForm = new GlobalKey<FormState>();
      });
    }
  }

  void refresh() {
    setState(() {
      _userController.text = '';
      _passController.text = '';
      _confirmPassController.text = '';
      _telephoneController.text = '';
      _keyForm = new GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastre-se"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refresh();
            },
          )
        ],
      ),
      body: Form(
        key: _keyForm,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.assignment,
                    size: 100,
                    color: Colors.green,
                  ),
                  TextFormField(
                    controller: _userController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.account_circle,
                        color: Colors.green,
                      ),
                      hintText: "Usuário",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha todos os campos corretamente";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _telephoneController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.call,
                        color: Colors.green,
                      ),
                      hintText: "Telefone",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha todos os campos corretamente";
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
                        color: Colors.green,
                      ),
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha todos os campos corretamente";
                      }
                    },
                  ),
                  TextFormField(
                    controller: _confirmPassController,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.vpn_key,
                        color: Colors.green,
                      ),
                      hintText: "Confirmar Senha",
                    ),
                    obscureText: true,
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
                  Divider(color: Colors.transparent),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Nota: ",style: TextStyle(color: Colors.green,fontSize: 20)),
                        Text("Estado padrão SP",style: TextStyle(fontSize: 20),)
                      ],
                    ),
                  Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(15),
                    child: IconButton(
                      icon: Icon(Icons.check,color: Colors.green),
                      iconSize: 40,
                        onPressed: () async {
                          if (_keyForm.currentState.validate()) {
                            if (_passController.text !=
                                _confirmPassController.text) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Senhas Diferentes",
                                          style: TextStyle(color: Colors.red)),
                                      content: Text(
                                          "As senhas são diferentes, preencha as senhas corretamente."),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Confirmar",
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
                              var user = User.add(
                                  _userController.text,
                                  _telephoneController.text,
                                  _confirmPassController.text,
                                  currentState);
                              this.result = await user.insertUser(user);
                              reset();
                              if (this.result == true) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Cadastro Concluido",
                                          style: TextStyle(color: Colors.green),
                                        ),
                                        content: Text(
                                            "Usuário cadastrado com sucesso."),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              "Confirmar",
                                              style:
                                              TextStyle(color: Colors.blue),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            color: Colors.transparent,
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          'Erro no Cadastro',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: Text(
                                            'Erro na conexão ou usuário já foi cadastrado, tente novamente'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'Confirmar',
                                              style:
                                              TextStyle(color: Colors.blue),
                                            ),
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
                        }
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
