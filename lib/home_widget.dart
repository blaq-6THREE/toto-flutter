import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_intro_page.dart';
import 'home_tabbed.dart';

class HomePage extends StatefulWidget {

  final FirebaseUser user;
  const HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum AuthStatus {
  notSignIn,
  signedIn
}

class _HomePageState extends State<HomePage> {

  AuthStatus status = AuthStatus.notSignIn;
  String uid;

  @override
  void initState() {

    super.initState();

    currentUser().then((userID) {
      setState(() {
        if (userID == null) {
          status = AuthStatus.notSignIn;
          uid = userID;
        }
        else {
          status = AuthStatus.signedIn;
          uid = userID;
        }
      });
    });
  }

  void signedIn() {
    setState(() {
      status = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case AuthStatus.notSignIn:
        return HomeIntro();
        break;
      case AuthStatus.signedIn:
        return HomeTabbed();
        break;
    }
  }

  Future<String> currentUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}