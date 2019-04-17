import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin/pages/home.dart';

class LoginPage extends StatefulWidget {
  
  LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    String _email;
    String _password;

    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
          backgroundColor: Colors.green,
        ),
        body: new Container(
          padding: new EdgeInsets.only(left:20.0, right: 20, top: 80),
          child: Form (
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (input) {
                    if (input.isEmpty) {
                      return "Please provide a proper email";
                    }
                  },
                  onSaved: (input) {
                    _email = input;
                  },
                  decoration: InputDecoration(labelText: "Email"),
                ),
                TextFormField(
                  validator: (input) {
                    if (input.length < 6) {
                      return "Please provide a password";
                    }
                  },
                  onSaved: (input) 
                  {
                    _password = input;
                  },
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                RaisedButton(onPressed: () {
                  signIn();
                },
                  child: Text("Sign In"),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
        formState.save();
        try {
          FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              Home(user: user)));

          widget.onSignedIn();
        }
        catch (e) {
          print(e.message);
        }
    }
  }
}