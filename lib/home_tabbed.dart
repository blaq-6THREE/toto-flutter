import 'package:flutter/material.dart';
import 'tab_widget.dart';
import 'profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeTabbed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeTabbedState();
  }
}

class _HomeTabbedState extends State<HomeTabbed> {
  
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}