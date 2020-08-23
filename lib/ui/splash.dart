//dart
import 'dart:async';

//packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/update_notice.dart';
import 'package:zikanri/ui/mypage.dart';
import 'package:zikanri/ui/welcome.dart';
import 'package:zikanri/config.dart';

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
    final userDataBox = await Hive.openBox('userData');
    final theme = Provider.of<ThemeNotifier>(context, listen: false);
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    //await Hive.box('theme').clear();
    //await Hive.box('userData').clear();
    if (userDataBox.containsKey('welcome')) {
      await userData.splashFunc();
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
