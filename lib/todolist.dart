import 'package:firebase_database/firebase_database.dart';

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