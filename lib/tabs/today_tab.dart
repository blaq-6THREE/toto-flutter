import 'package:flutter/material.dart';

// TODO: DO not forget to add APIKEY

import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:signin/data/todolist.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {

  final formats = {
    InputType.time: DateFormat("HH:mm"),
    InputType.date: DateFormat('yyyy-MM-dd'),
  };

  String apiKey = "AIzaSyBrii-n_FsOb96YDr-xb2ZLqiPUIhKv0Fc";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController alarmController = TextEditingController();

  List<TodoList> listsTodoList = List();
  List<String> list = List();

  DatabaseReference userRef;
  TodoList todoList;

  // Will be going to tomorrow view
  DatabaseReference ref;
  String uid;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    todoList = TodoList("", "", "", "", "");
    final FirebaseDatabase database = FirebaseDatabase.instance;

    currentUser().then((userID){
      uid = userID;
      
      userRef = database.reference().child('user').child(uid).child('today');

    }).then((_) {
      userRef.onChildAdded.listen(_onEntryAdded);
      userRef.onChildChanged.listen(_onEntryChanged);
    });
  }

  // This adds the todoList to the dataBase
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
      listsTodoList[listsTodoList.indexOf(old)] = TodoList.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Center (
        child: Container (
          child: FirebaseAnimatedList (
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
                onLongPress: () {
                  // The Todo Item will be editted when long pressed
                  print(Text(listsTodoList[index].title));
                  print(Text(listsTodoList[index].decsription));
                  print(Text(listsTodoList[index].location));
                  print(Text(listsTodoList[index].alarm));
                  print(Text(listsTodoList[index].currentDate));
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print("${uid}");
          _showDialog(context).then((value) {

            todoList.title = value[0];
            todoList.decsription = value[1];
            todoList.location = value[2];
            todoList.alarm = value[3];
            todoList.currentDate = value[4];

            userRef.push().set(todoList.toJson()).then((value) {
              Fluttertoast.showToast(
                msg: "List added to today",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );
            });
          });
        },
      ),      
    );
  }

  // user defined function
  Future<List<String>> _showDialog(BuildContext context) async {
    return await showDialog<List<String>>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add to TODAY", style: TextStyle(color: Colors.blue),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[

                // Title and Descrition
                Column (
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.title)
                      ),
                      autofocus: true,
                      controller: titleController,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.description)
                      ),
                      controller: descriptionController,
                    ),
                  ],
                ),

                // This is the divider
                Divider(
                  color: Colors.red,
                ),
                
                // Lication and Alarm
                Column(
                  children: <Widget>[
                    PlacesAutocompleteField(
                      apiKey: apiKey,
                      inputDecoration: InputDecoration(icon: Icon(Icons.location_on)),
                      controller: locationController,
                    ),
                    DateTimePickerFormField(
                      inputType: InputType.time,
                      editable: true,
                      format: DateFormat.Hm(),
                      decoration: InputDecoration(
                        icon: Icon(Icons.alarm)
                      ),
                      resetIcon: Icons.close,
                      controller: alarmController,
                    ),
                  ],
                ),                           
              ],
            ),
          ),
          
          // These specify the action that should take place after
          actions: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                child: Text('Cancel', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                ),
                FlatButton(
                  child: Text("Create", style: TextStyle(color: Colors.green),),
                  onPressed: (){

                    list.add(titleController.text);
                    list.add(descriptionController.text);
                    list.add(locationController.text);
                    list.add(alarmController.text);
                    list.add(DateTime.now().toLocal().toString());

                    Navigator.of(context).pop(list);
                    // https://tphangout.com/flutter-lists-and-dialogs/
                  },
                )
              ],
            )
          ],
        );
      },
    );
  }

  Future<String> currentUser() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }
}