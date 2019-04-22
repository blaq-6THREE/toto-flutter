import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_intro_page.dart';

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
  String email;

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
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: <Widget>[
            FlatButton(
              child: Text("Sign out"),
              onPressed: () {
                // print("${uid}");
                signOut();
              },
            )
          ],
        ),
      )
    );
  }

  Future<void> signOut() async {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeIntro()));
    }
    catch (e) {
      print(e.message);
    }
  }
}

Future<String> currentUser() async{
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user.uid;
}