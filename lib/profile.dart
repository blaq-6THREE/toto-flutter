import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin/pages/Setup/signin.dart';

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
    // TODO: implement initState
    super.initState();

    currentUser().then((userID) {
      setState(() {
        //status = userID
        if (userID == null) {
          status = AuthStatus.notSignIn;
          uid = userID;
        }
        else {
          status = AuthStatus.signedIn;
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
        return LoginPage(onSignedIn: signedIn);
        break;
      case AuthStatus.signedIn:
        // Take em to a full profile page
        return Scaffold(
          appBar: AppBar(
            title: Text("Signed in as $uid"),
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
