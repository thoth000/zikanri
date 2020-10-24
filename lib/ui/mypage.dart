//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/main_page_controller.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/ui/home/home.dart';
import 'package:zikanri/ui/lately/lately.dart';
import 'package:zikanri/ui/previous_records/previous_records.dart';
import 'package:zikanri/ui/setting/setting.dart';
import 'package:zikanri/ui/record/record_button.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/users/users.dart';

class MyAppPage extends StatelessWidget {
  MyAppPage._({Key key}) : super(key: key);
  final List pages = [
    HomePage(),
    LatelyPage.wrapped(),
    PRPage(),
    UsersPage(),
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
    final controller = Provider.of<MainPageController>(context);
    return Scaffold(
      body: SafeArea(child: pages[controller.currentIndex]),
      floatingActionButton: RecordButton(),
      bottomNavigationBar: BottomAppBar(
        child: _IconList(),
      ),
    );
  }
}

class _IconList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconList = [
      Icons.home,
      Icons.today,
      Icons.assessment,
      Icons.people,
      Icons.settings,
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(
        iconList.length,
        (index) {
          return _NavigateIconButton(
            navigateIndex: index,
            icon: iconList[index],
          );
        },
      ),
    );
  }
}

class _NavigateIconButton extends StatelessWidget {
  _NavigateIconButton({@required this.navigateIndex, @required this.icon});
  final int navigateIndex;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final controller = Provider.of<MainPageController>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    final double iconsize = displaySize.width / 9.5;
    return IconButton(
      icon: Icon(icon),
      iconSize: iconsize,
      color: (controller.currentIndex == navigateIndex) ? color : Colors.grey,
      onPressed: () {
        controller.changePage(navigateIndex);
      },
    );
  }
}
