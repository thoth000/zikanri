import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../previous_records/previous_records.dart';
import '../../user/user.dart';
import '../../Setting/Setting.dart';
import '../../home/home.dart';
import '../../data.dart';
import 'drawer_header.dart';

class SlideMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Drawer(
      child: Stack(
        children: <Widget>[
          _drawerListView(context),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              //TODO:think
              padding: EdgeInsets.only(bottom: displaySize.width / 8 + 20.0),
              child: Container(height: 1.0, color: Colors.grey),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: isThemeButton(theme),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: resisterButton(context, theme, userData),
          ),
        ],
      ),
    );
  }

  Widget _drawerListView(
    context,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: displaySize.width / 8 + 20.0),
      child: ListView(
        children: <Widget>[
          DHWidget(),
          FlatButton(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.home,
                    size: displaySize.width / 8,
                    color: Colors.grey[700],
                  ),
                  Text(
                    '  ホーム',
                    style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.assessment,
                    size: displaySize.width / 8,
                    color: Colors.grey[700],
                  ),
                  Text(
                    ' これまでの記録',
                    style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PRPage(),
                ),
              );
            },
          ),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.supervised_user_circle,
                    size: displaySize.width / 8,
                    color: Colors.grey[700],
                  ),
                  Text(
                    '  ユーザー',
                    style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UserPage(),
                ),
              );
            },
          ),
          FlatButton(
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: displaySize.width / 8,
                    color: Colors.grey[700],
                  ),
                  Text(
                    '  設定',
                    style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingPage(),
                ),
              );
            },
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  Widget isThemeButton(theme) {
    return IconButton(
      icon: Icon(Icons.lightbulb_outline),
      iconSize: displaySize.width / 11,
      color: Colors.grey[700],
      onPressed: () => theme.changeMode(),
    );
  }

  Widget resisterButton(context, theme, userData) {
    if (userData.registerCheck == false) {
      return FlatButton(
          padding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(80.0)),
          ),
          child: Container(
            height: displaySize.width / 8,
            width: displaySize.width / 3,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: theme.themeColors),
              borderRadius:
                  BorderRadius.all(Radius.circular(displaySize.width)),
            ),
            child: Center(
              child: Text(
                'アカウント登録',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: FontSize.xsmall,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          });
    } else {
      return Container();
    }
  }
}
