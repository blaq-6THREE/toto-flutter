import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:signin/todolist.dart';
import 'package:firebase_database/firebase_database.dart';

class TodayScreen extends StatefulWidget {
  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {

  List<TodoList> listsTodoList = List();
  DatabaseReference userRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
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
    );
  }
}

// TODO: This can be fixed and returned as the we listview
// return ListView(
//   children: ListTile.divideTiles(
//     context: context,
//     tiles: [
//       ListTile(
//         leading: Icon(Icons.alarm),
//         title: Text(listsTodoList[index].title),
//         subtitle: Text(listsTodoList[index].decsription),
//         dense: true,
//         trailing: Text(listsTodoList[index].alarm, style: TextStyle(
//           color: Colors.green
//           ),
//         ),
//         onTap: () {
          
//         },
//       ),
//     ]
//   ).toList(),
// );