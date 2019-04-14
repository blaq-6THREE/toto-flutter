import 'package:flutter/material.dart';
import 'package:signin/pages/Setup/SignUp.dart';
import 'package:signin/pages/Setup/signin.dart';

class ProfileIntro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
            ),
            RaisedButton(
              child: Text("Sign In"),
              color: Colors.green,
              onPressed: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => new LoginPage()));
                return null;
              },
            ),
            Divider(
              height: 1.0,
              color: Colors.red[800],
            ),
            RaisedButton(
              child: Text("Register"),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) => new SignUp()));
              },
            )
          ],
        ),
      ),
    );
  }
}

// This PAGE is all set!