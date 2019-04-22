import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin/home_tabbed.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register'),
        ),
        body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Please provide your name";
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(labelText: "name"),
                ),
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Please provide a proper email";
                    }
                  },
                  onSaved: (input) => _email = input,
                  decoration: InputDecoration(labelText: "email"),
                ),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return "Please provide a password";
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(labelText: "password"),
                  obscureText: true,
                ),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return "Please provide a password";
                    }
                  },
                  onSaved: (input) => _password = input,
                  decoration: InputDecoration(labelText: "retype password"),
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: () {
                    signUp();
                  },
                  child: Text("Register"),
                )
              ],
            ),
          ),
        )
    );
  }

  void signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeTabbed()));
      } catch (e) {}
    }
  }
}
