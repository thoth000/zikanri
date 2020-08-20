import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/theme_notifier.dart';

import 'home/home.dart';
import 'lately/lately.dart';
import 'previous_records/previous_records.dart';
import 'setting/setting.dart';
import 'home/record_button.dart';
import 'data.dart';

class MyAppPage extends StatelessWidget {
  MyAppPage._({Key key}) : super(key: key);
  final List pages = [
    HomePage(),
    LatelyPage(),
    PRPage(),
    SettingPage(),
  ];

  static Widget wrapped() {
    return ChangeNotifierProvider<MainPageController>(
      create: (_) => MainPageController(),
      child: MyAppPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final controller = Provider.of<MainPageController>(context);
    Color color = theme.isDark ? theme.themeColors[0] : theme.themeColors[1];
    double iconsize = displaySize.width / 9.5;
    return Scaffold(
      body: SafeArea(child: pages[controller.currentIndex]),
      floatingActionButton: RButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              iconSize: iconsize,
              color: (controller.currentIndex == 0) ? color : Colors.grey,
              onPressed: () {
                controller.changePage(0);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.today,
              ),
              iconSize: iconsize,
              color: (controller.currentIndex == 1) ? color : Colors.grey,
              onPressed: () {
                controller.changePage(1);
              },
            ),
            SizedBox(
              width: displaySize.width / 5,
            ),
            IconButton(
              icon: const Icon(Icons.assessment),
              iconSize: iconsize,
              color: (controller.currentIndex == 2) ? color : Colors.grey,
              onPressed: () {
                controller.changePage(2);
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              iconSize: iconsize,
              color: (controller.currentIndex == 3) ? color : Colors.grey,
              onPressed: () {
                controller.changePage(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MainPageController with ChangeNotifier {
  int currentIndex = 0;
  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
