import 'package:flutter/material.dart';

class TomorrowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Image.asset('assets/images/no_list.png', scale: 3,),
        ),
      ),
    );
  }
}