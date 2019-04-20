import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:intl/intl.dart';
import 'package:signin/data/todolist.dart';

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

    todoList = TodoList("", "", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;
    
    userRef = database.reference().child('user').child('tomorrow');
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
    // final FormState form = formKey.currentState;
    
    userRef.push().set(todoList.toJson());

    // if (form.validate()) {
    //   form.save();
    //   form.reset();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container (
          child: FirebaseAnimatedList(
            query: userRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
              return ListTile(
                leading: Icon(Icons.alarm),
                title: Text(listsTodoList[index].title),
                subtitle: Text(listsTodoList[index].decsription),
                // isThreeLine: true,
                // dense: true,
                trailing: Text(listsTodoList[index].alarm, style: TextStyle(
                  color: Colors.green
                  ),
                ),
                onTap: () {
                  print(Text(listsTodoList[index].title));
                },
              );
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print(new DateFormat.yMd().format(new DateTime.now()));

          todoList.title = "value";
          todoList.decsription = "value";
          todoList.location = "value";
          todoList.alarm = "value"; 
          todoList.currentDate = DateTime.now().toLocal().toString();

          handleSubmit();
        },
      ),
    );
  }
  // https://medium.com/@studymongolian/a-complete-guide-to-flutters-listtile-597a20a3d449

  void fromTodayToMorrow(){
    // Get the current date on phone
    // Get the current a 
    // First get date date of the todo list with now() method
    var now = DateTime.now().toLocal();
    var tomorrow = DateTime.now().toLocal().add(Duration(days: 1)).toLocal();

    print("Today is ${now.toLocal()}");
    print("Tomorrow is ${tomorrow.toLocal()}");
  }
}