import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_intro_page.dart';

class ProfilePage extends StatefulWidget {

  final FirebaseUser user;
  const ProfilePage({Key key, this.user}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

enum AuthStatus {
  notSignIn,
  signedIn
}

class _ProfilePageState extends State<ProfilePage> {

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
        // Take em to a page with two buttons
        // return LoginPage(onSignedIn: signedIn);
        return ProfileIntro();
        break;
      case AuthStatus.signedIn:
        // Take em to a full profile page
        return Scaffold(
          appBar: AppBar(
            title: Text(uid),
          ),
        );
        break;
    }
  }

  Future<String> currentUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}