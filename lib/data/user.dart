import 'package:firebase_database/firebase_database.dart';

class TodoList {
  String key;
  String name;
  String email;

  TodoList(this.name, this.email,);

  TodoList.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "name": name,
      "email": email,
    };
  }
}