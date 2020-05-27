import 'package:flutter/material.dart';
import 'sign_up.dart';
import 'menu.dart';
import 'models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String param = "";

  void refresh() {
    setState(() {
      _formKey = GlobalKey<FormState>();
      _userController = TextEditingController();
      _passwordController = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
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
                      hintText: "Usuário(a)",
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Preencha todos os campos corretamente";
                      }
                    },
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    controller: _passwordController,
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
                  Divider(
                    color: Colors.transparent,
                  ),
                  IconButton(
                    icon: Icon(Icons.send,color: Colors.green,),
                    iconSize: 40,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          param = _userController.text;
                          User user = new User.login(
                              _userController.text, _passwordController.text);

                          var result =
                          await user.loginUser(user.username, user.password);
                          if (result > 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu(param)));
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Erro no Login",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    content:
                                    Text("Usuário ou senha incorreto(a)."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          "Confirmar",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                          refresh();
                        }
                      }
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Não é cadastrado?"),
                      FlatButton(
                        color: Colors.transparent,
                        child: Text("Cadastra-se"),
                        textColor: Colors.green,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SignUp();
                            }
                          ));
                        },
                      ),
                    ],
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
