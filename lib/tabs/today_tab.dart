// FirstScreen.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:signin/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {

  final mainReference = FirebaseDatabase.instance.reference();

  String apiKey = "AIzaSyBrii-n_FsOb96YDr-xb2ZLqiPUIhKv0Fc";

  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('EEE, M/d/y'),
    InputType.time: DateFormat("HH:mm"),
  };

  // Changeable in demo
  InputType inputType = InputType.time;
  bool editable = true;
  DateTime date;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/no_list.png',
            scale: 4,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _alertDialogue();
          },
        ),
      ),
    );
  }

  Future<String> _alertDialogue() async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          true, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Todo Item for morrow'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Title",
                    icon: Icon(Icons.title)
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "description",
                    icon: Icon(Icons.description)
                  ),
                ),
                Divider(color: Colors.red),
                PlacesAutocompleteField(
                  apiKey: apiKey,
                  hint: "location",
                  language: "us",
                  inputDecoration: InputDecoration(
                    icon: Icon(Icons.location_on)
                  ),
                ),
                DateTimePickerFormField(
                  format: formats[inputType],
                  inputType: inputType,
                  editable: true,
                  decoration: InputDecoration(
                    labelText: "alarm",
                    icon: Icon(Icons.alarm)
                  ),
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            RaisedButton(
              child: Text('Ok'),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {
                // Todo: Add to Database
                addToDatabase();
              },
            ),
            RaisedButton(
              child: Text("Cancel"),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {
                
              },
            )
          ],
        );
      },
    );
  }

  // Todo: Write to database
  void addToDatabase() {
    
  }
}