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
          child: Image.asset(
            'assets/images/no_list.png',
            scale: 3,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _alertDialogue(context);
          },
        ),
      ),
    );
  }

  Future<String> _alertDialogue(BuildContext context) async {
    bool isChecked;

    return showDialog<String>(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Todo Item for morrow'),
          content: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: "Title", hintText: "buy creator lunch"),
              ),
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Descripton",
                  hintText: "taco lupita looks lit right now"),
              ),
              Divider(color: Colors.red),
              Container(
                // TODO: checkbox, Text() and Textfield, location image
                child: Row(
                  children: <Widget>[
                    Text("data"),
                    Text("Location"),
                    Text("data")
                  ],
                ),
              ),
              Container(
                  // TODO: checkbox, Text() and Textfield, alarm image
                  child: Row(
                children: <Widget>[
                  Text("data"),
                  Text("Location"),
                  Text("data")
                ],
              ))
            ],
          ),
          backgroundColor: Color.fromRGBO(93, 92, 92, 1),
          actions: <Widget>[
            RaisedButton(
              child: Text('Ok'),
              color: Colors.blue,
              textColor: Colors.white,
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
            RaisedButton(
              child: Text("Cancel"),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {},
            )
          ],
        );
      },
    );
  }
}
