import 'package:flutter/material.dart';
import 'package:signin/pages/Setup/SignUp.dart';
import 'package:signin/pages/Setup/signin.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
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
