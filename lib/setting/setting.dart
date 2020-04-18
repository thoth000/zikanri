import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import '../main.dart';

import 'package:zikanri/items/drawer/drawer.dart';
import '../data.dart';


class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '設定',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      drawer: SlideMenu(),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Card(
          child: Wrap(
            children: <Widget>[
              for (int i = 0; i < theme.myColors.length; i++)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: themeChanger(theme, i),
                ),
              RaisedButton(
                onPressed: (){
                  Hive.box('theme').clear();
                  Hive.box('userData').clear();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget themeChanger(theme, i) {
    return Container(
      height: displaySize.width / 8,
      width: displaySize.width / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(colors: baseColors[int.parse(theme.myColors[i])]),
      ),
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 0,
        onPressed: () => theme.changeTheme(i),
      ),
    );
  }
}
