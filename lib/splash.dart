import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'mypage.dart';
import 'welcome.dart';
import 'data.dart';

class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var box1;
  var box2;
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future _initialize() async {
    final theme = Provider.of<ThemeNotifier>(context, listen: false);
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    await Hive.initFlutter();
    await Hive.openBox('theme');
    await Hive.openBox('userData');
    if (Hive.box('userData').containsKey('welcome')) {
      final date = DateFormat("yyyy年MM月dd日").format(DateTime.now());
      final month = DateFormat("MM").format(DateTime.now());
      if (date != Hive.box('userData').get('previousDate')) {
        var box = Hive.box('userData');
        await box.put('previousDate', date);
        await box.put('todayDoneList', []);
        box1 = box.get('latelyData');
        if (box1.length >= 14) {
          box1.removeAt(0);
        }
        box1.add([date, 0, 0, 0, []]);
        await box.put('latelyData', box1);
        box2 = box.get('userValue');
        if (month != box.get('thisMonth')) {
          box2[3] = 0;
          box2[4] = 0;
          box2[5] = 0;
          await box.put('passedDays', 1);
        } else {
          await box.put('passedDays', box.get('passedDays') + 1);
        }
        box2[6] = 0;
        box2[7] = 0;
        box2[8] = 0;
        await box.put('userValue', box2);
        await box.put('totalPassedDays', box.get('totalPassedDays') + 1);
      }
      await theme.initialize();
      await userData.initialize();
      Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyAppPage(),
          ),
        ),
      );
    } else {
      Future.delayed(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    displaySize = MediaQuery.of(context).size;
    var width = displaySize.width;
    var height = displaySize.height;
    if (width > height) {
      width = height;
    }

    return Scaffold(
      backgroundColor: Color(0XFFFAFAFA),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: displaySize.width / 2,
              width: displaySize.width / 2,
              child: Image(
                image: AssetImage('images/zikanri_shaped.png'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: displaySize.width / 10),
              child: Text(
                'Zikanri',
                style: TextStyle(
                  fontSize: FontSize.big,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF3A405A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
