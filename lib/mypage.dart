import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';
import 'lately/lately.dart';
import 'previous_records/previous_records.dart';
import 'setting/setting.dart';
import 'home/record_button.dart';
import 'data.dart';

class MyAppPage extends StatefulWidget {
  @override
  _MyAppPageState createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
  int _currentIndex = 0;
  List pages = [
    HomePage(),
    LatelyPage(),
    PRPage(),
    SettingPage(),
  ];

  List tmp = [
    Container(color: Colors.red,),
    Container(color: Colors.blue,),
    Container(color: Colors.green,),
    Container(color: Colors.yellow,),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    Color color = theme.isDark ? theme.themeColors[0] : theme.themeColors[1];
    double iconsize = displaySize.width/11;
    return Scaffold(
      body: SafeArea(child:pages[_currentIndex]),
      floatingActionButton: RButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              iconSize: iconsize,
              color: (_currentIndex == 0) ? color : Colors.grey,
              onPressed: () {
                setState(
                  () {
                    _currentIndex = 0;
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.today),
              iconSize: iconsize,
              color: (_currentIndex == 1) ? color : Colors.grey,
              onPressed: () {
                setState(
                  () {
                    _currentIndex = 1;
                  },
                );
              },
            ),
            SizedBox(
              width: displaySize.width/5,
            ),
            IconButton(
              icon: Icon(Icons.assessment),
              iconSize: iconsize,
              color: (_currentIndex == 2) ? color : Colors.grey,
              onPressed: () {
                setState(
                  () {
                    _currentIndex = 2;
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              iconSize: iconsize,
              color: (_currentIndex == 3) ? color : Colors.grey,
              onPressed: () {
                setState(
                  () {
                    _currentIndex = 3;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
