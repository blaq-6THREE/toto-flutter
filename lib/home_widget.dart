import 'package:flutter/material.dart';
import 'tab_widget.dart';
import 'profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;


  final List<Widget> _children = [
    TabbedWidget(Colors.cyan), // Let this be today & tomorrow
    ProfilePage() // This links to the profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        // backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          //Handle button tap
          onTabTapped(index);
        },
        color: Colors.blue[800],
      ),
      body: _children[_currentIndex],
    );
  }

  // This is the old Scoffold
  // Scaffold(
  //     body: _children[_currentIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       onTap: onTabTapped,
  //       currentIndex: _currentIndex, // this will be set when a new tab is tapped
  //       items: [
  //         BottomNavigationBarItem(
  //           icon: new Icon(Icons.home),
  //           title: new Text('Home'),
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person),
  //           title: Text("Profile"))
  //       ],
  //     ),
  //   )

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
