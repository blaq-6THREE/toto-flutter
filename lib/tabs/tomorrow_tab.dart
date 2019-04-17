import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class TomorrowScreen extends StatefulWidget {
  @override
  _TomorrowScreenState createState() => _TomorrowScreenState();
}

class _TomorrowScreenState extends State<TomorrowScreen> {
  List<TodoList> listsTodoList = List();
  TodoList todoList;
  DatabaseReference userRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    todoList = TodoList("", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    userRef = database.reference().child('user');
    userRef.onChildAdded.listen(_onEntryAdded);
    userRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      listsTodoList.add(TodoList.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = listsTodoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      listsTodoList[listsTodoList.indexOf(old)] =
          TodoList.fromSnapshot(event.snapshot);
    });
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      userRef.push().set(todoList.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.title),
                  //border: OutlineInputBorder(),
                  labelText: "title"),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                todoList.title = value;
              },
            ),
            // This is the decription
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  //border: OutlineInputBorder(),
                  labelText: "description"),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                todoList.decsription = value;
              },
            ),
            // This is the location textfield
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.location_on),
                  //border: OutlineInputBorder(),
                  labelText: "location"),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                todoList.location = value;
              },
            ),
            TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.alarm),
                  //border: OutlineInputBorder(),
                  labelText: "alarm"),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                todoList.alarm = value;
              },
            ),
            RaisedButton(
              child: Text("Push to Database"),
              onPressed: () {
                handleSubmit();
              },
            )
          ],
        ),
        ),
      )
    );
  }
}

class TodoList {
  String key;
  String title;
  String decsription;
  String location;
  String alarm;

  TodoList(this.title, this.decsription, this.location, this.alarm);

  TodoList.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        title = snapshot.value["title"],
        decsription = snapshot.value["decsription"],
        location = snapshot.value["location"],
        alarm = snapshot.value["alarm"];

  toJson() {
    return {
      "title": title,
      "decsription": decsription,
      "location": location,
      "alarm": alarm,
    };
  }
}