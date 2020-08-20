import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';

import '../data.dart';

class ThemeSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'テーマの変更',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: displaySize.width / 20),
                child: Container(
                  height: displaySize.width / 2.2,
                  width: displaySize.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: theme.themeColors),
                    borderRadius: BorderRadius.all(
                        Radius.circular(displaySize.width / 12)),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1.0,
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(10, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: displaySize.width / 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: null,
                            iconSize: displaySize.width / 15,
                            icon: Icon(null),
                          ),
                          Text(
                            'Good Rate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.xlarge, //12.5
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: displaySize.width / 15,
                            ),
                            onPressed: null,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: displaySize.width / 100,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: displaySize.width / 30),
                        child: SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              '7777',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSize.big,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
          const Divider(
            height: 30,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Container(
            height: displaySize.width / 9,
            width: displaySize.width,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ダークモード',
                  style: TextStyle(
                    fontSize: FontSize.midium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Switch(
                  value: theme.isDark,
                  onChanged: (boolean) => theme.changeMode(),
                  activeColor: (theme.isDark)
                      ? theme.themeColors[0]
                      : theme.themeColors[1],
                ),
              ],
            ),
          ),
          const Divider(
            height: 30,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'テーマ一覧',
                  style: TextStyle(
                      fontSize: FontSize.midium, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: <Widget>[
                    for (int i = 0; i < baseColors.length; i++)
                      _ThemeChanger(i),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeChanger extends StatelessWidget {
  _ThemeChanger(this.i);
  final int i;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    if (userData.myColors[i]) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: displaySize.width / 8,
          width: displaySize.width / 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
              colors: baseColors[i],
            ),
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Colors.transparent,
            child: const SizedBox(),
            onPressed: () async => await theme.changeTheme(i),
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
