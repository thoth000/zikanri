import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:package_info/package_info.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/update_notice.dart';

import 'mypage.dart';
import 'welcome.dart';
import 'data.dart';

class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    print(version);
    await Hive.initFlutter();
    final userDataBox = await Hive.openBox('userData');
    final theme = Provider.of<ThemeNotifier>(context, listen: false);
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    //await Hive.box('theme').clear();
    //await Hive.box('userData').clear();
    if (userDataBox.containsKey('welcome')) {
      final date = DateFormat('yyyy年MM月dd日').format(DateTime.now());
      final month = DateFormat('MM').format(DateTime.now());
      if (date != userDataBox.get('previousDate')) {
        await userDataBox.put('previousDate', date);
        await userDataBox.put('todayDoneList', []);
        var latelyData = userDataBox.get('latelyData');
        if (latelyData.length >= 8) {
          latelyData.removeAt(0);
        }
        latelyData.add([date, 0, 0, 0, []]);
        await userDataBox.put('latelyData', latelyData);
        var userValue = userDataBox.get('userValue');
        if (month != userDataBox.get('thisMonth')) {
          userDataBox.put('backupFinish', false);
          userDataBox.put('takeoverFinish', false);
          userValue[3] = 0;
          userValue[4] = 0;
          userValue[5] = 0;
          await userDataBox.put('thisMonth', month);
          await userDataBox.put('passedDays', 1);
        } else {
          await userDataBox.put(
              'passedDays', userDataBox.get('passedDays') + 1);
        }
        userValue[6] = 0;
        userValue[7] = 0;
        userValue[8] = 0;
        await userDataBox.put('userValue', userValue);
        await userDataBox.put(
            'totalPassedDays', userDataBox.get('totalPassedDays') + 1);
      }
      await theme.initialize();
      await userData.initialize();
      await userData.updateCheckD(userDataBox.get('totalPassedDays'));
      //version違う場合：1.1.0～ユーザー
      if (version != await Hive.box('userData').get('version')) {
        Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateNoticePage(
                newVersion: version,
              ),
            ),
          ),
        );
      }
      //version合ってる場合
      else {
        Future.delayed(
          const Duration(seconds: 1),
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyAppPage.wrapped(),
            ),
          ),
        );
      }
      //初めての場合
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => WelcomePage(
              version: version,
            ),
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
      backgroundColor: const Color(0XFFFAFAFA),
      body: Stack(
        children: <Widget>[
          Center(
            child: SizedBox(
              height: displaySize.width / 2,
              width: displaySize.width / 2,
              child: const Image(
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
                  color: const Color(0XFF3A405A),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
