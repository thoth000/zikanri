import 'dart:async';
//packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:package_info/package_info.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';
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

  void _initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    final userDataBox = await Hive.openBox('userData');
    final theme = Provider.of<ThemeNotifier>(context, listen: false);
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    if (userDataBox.containsKey('welcome')) {
      await userData.splashFunc();
      await theme.initialize();
      final List<dynamic> getCategory = await userDataBox.get('categories');
      if (getCategory[0][0] == 57746) {
        await userData.switchIconNum();
      }
      await userData.initialize();
      await userData.updateCheckD(userDataBox.get('totalPassedDays'));
      //version違う場合：1.1.0～ユーザー
      if (version != await Hive.box('userData').get('version')) {
        await Future.delayed(const Duration(milliseconds: 600));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateNoticePage(
              newVersion: version,
            ),
          ),
        );
      }
      //version合ってる場合
      else {
        final UsersController usersController =
            Provider.of<UsersController>(context, listen: false);
        final List<String> ids = userData.favoriteIDs;
        if (ids.isNotEmpty) {
          usersController.getFavoriteUsers(ids);
          usersController.getFeaturedUsers();
        }
        await Future.delayed(Duration(milliseconds: 600));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyAppPage.wrapped(),
          ),
        );
      }
      //初めての場合
    } else {
      await Future.delayed(const Duration(milliseconds: 600));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(
            version: version,
          ),
        ),
      );
    }
  }
}
