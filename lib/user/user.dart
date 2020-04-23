import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';

import '../items/drawer/drawer.dart';

class UserPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'ユーザー',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: SlideMenu(),
      body: Container(),
    );
  }
}
