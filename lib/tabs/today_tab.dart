// FirstScreen.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class TodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Image.asset('assets/images/no_list.png', scale: 3,),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Fluttertoast.showToast(
            msg: "This is Center Short Toast",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
          },
        ),
      ),
    );
  }
}