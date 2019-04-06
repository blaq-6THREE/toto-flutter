import 'package:flutter/material.dart';
import 'tabs/today_tab.dart';
import 'tabs/tomorrow_tab.dart';

class TabbedWidget extends StatelessWidget {
  final Color color;

  TabbedWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.arrow_downward)),
                Tab(icon: Icon(Icons.subdirectory_arrow_right))
              ],
            ),
            centerTitle: true,
            title: Text('Today, Tomorrow', style: TextStyle(color: Colors.white)),
          ),
          body: TabBarView(
            children: [
              TodayScreen(),
              TomorrowScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstScreen {
}
