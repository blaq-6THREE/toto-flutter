import 'package:flutter/material.dart';
import 'pages/Setup/signin.dart';

import 'pages/Setup/SignUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {

  final FirebaseUser user;
  const ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              navigateToSignIn();
            },
            child: Text("Sign in"),
          ),
          RaisedButton(
            onPressed: () {
              navigateToSignUp();
            },
            child: Text("Register"),
          )
        ],
      ),
    );
  }

  void navigateToSignIn()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage
      (), fullscreenDialog: true));
  }

  void navigateToSignUp()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp
      (), fullscreenDialog: true));
  }
}
