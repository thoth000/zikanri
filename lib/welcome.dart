import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/data.dart';

import 'home/home.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reload = Provider.of<ReloadNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    Route _createRoute() {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    void changepage() {
      Navigator.pushReplacement(context, _createRoute());
    }

    void makeDir(resistercheck) async {
      //アプリ初回起動時の動作
      var firstdate = DateFormat("yyyy年MM月dd日").format(DateTime.now());
      var firstMonth = DateFormat("MM").format(DateTime.now());
      var themeBox = Hive.box('theme');
      var userDataBox = Hive.box('userData');
      //theme
      await themeBox.put('isDark', false);
      await themeBox.put('themeColorsIndex', 0);
      await themeBox.put('myColors', ['0', '1', '2', '3', '4', '5', '6', '7']);
      //userData
      await userDataBox.put('welcome', "Yey!");
      /*userValue=[
        totalP,
        thisMonthP,thisMonthM,thisMonthV,thisMonthA,
        todayP,todayM,todayV,
        ]*/
      await userDataBox.put('userValue', [0, 0, 0, 'NaN', 0, 0, 0, 'NaN']);
      await userDataBox.put('latelyData', [
        [firstdate, 0, 0, 'NaN', []],
      ]);
      await userDataBox.put('todayDoneList', []);
      await userDataBox.put(
        'shortCuts',
        [
          ['57680', '数学の勉強', '60', '1', '300'],
          ['58726', 'バスケの練習', '120', '1', '480'],
          ['58168', 'ひと狩り', '120', '0', '240'],
        ],
      );
      await userDataBox.put('activities', []);
      await userDataBox.put('userName', 'ゲスト');
      await userDataBox.put('userID', '');
      await userDataBox.put('resisterCheck', resistercheck);
      await userDataBox.put('previousDate', firstdate);
      await userDataBox.put('thisMonth', firstMonth);
      await userDataBox.put('passedDays', 1);
      await userDataBox.put('totalPassedDays', 1);
      theme.initialize();
      userData.initialize();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 30,
              width: 50,
              child: FlatButton(
                color: Colors.green,
                onPressed: () async {
                  reload.reloded();
                  makeDir(false);
                  Timer(Duration(milliseconds: 2000), reload.finishload);
                  Timer(Duration(seconds: 2500), changepage);
                },
                child: Container(),
              ),
            ),
          ),
          Center(
            child: (reload.reload)
                ? Container(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
