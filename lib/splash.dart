import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'home/home.dart';
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
    await Hive.openBox('theme');
    await Hive.openBox('userData');
    if (Hive.box('userData').containsKey('welcome')) {
      final date = DateFormat("yyyy年MM月dd日").format(DateTime.now());
      final month = DateFormat("MM").format(DateTime.now());
      if (date != Hive.box('userData').get('previousDate')) {
        var box = Hive.box('userData');
        var additem = box.get('latelyData');
        if(additem.length>=14){
          additem.removeAt(0);
        }
        additem.add([date, 0, 0, '0.00', []]);
        await box.put('latelyData', additem);
        await box.put('todayDoneLisy', []);
        additem = box.get('userValue');
        if (month != box.get('thisMonth')) {
          additem[1] = 0;
          additem[2] = 0;
          additem[3] = '0.00';
          additem[4] = 0;
          await box.put('passedDays', 1);
        } else {
          await box.put('passedDays', box.get('passedDays') + 1);
        }
        additem[5] = 0;
        additem[6] = 0;
        additem[7] = '0.00';
        await box.put('userValue', additem);
        await box.put('totalPassedDays', box.get('totalPassedDays') + 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    displaySize = MediaQuery.of(context).size;
    print(displaySize);
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final bool firstcheck = Hive.box('userData').containsKey('welcome');
    var width = displaySize.width;
    var height = displaySize.height;
    if (width > height) {
      width = height;
    }
    Route _createRoute(page) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
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

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'images/splash_deco.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Zikanri',
                    style: TextStyle(
                      color: Color(0XFF3A405A),
                      fontWeight: FontWeight.w700,
                      fontSize: width / 8,
                    ),
                  ),
                  Text(
                    '毎日をより価値あるものに',
                    style: TextStyle(
                      fontSize: width / 25,
                      color: Color(0XFF3A405A),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: firstcheck ? 0 : width / 6.5 + 25,
                  ),
                  Container(
                    height: width / 2,
                    width: width / 2,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          color: Colors.black38,
                          offset: Offset(5, 10),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: <Widget>[
                        Image.asset('images/zikanri_shaped.png'),
                        SizedBox(
                          height: width / 2,
                          width: width / 2,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.transparent,
                            child: Container(),
                            onPressed: () {
                              displaySize = MediaQuery.of(context).size;
                              if (Hive.box('userData').containsKey('welcome')) {
                                theme.initialze();
                                userData.initialze();
                                Navigator.pushReplacement(
                                  context,
                                  _createRoute(HomePage()),
                                );
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  _createRoute(WelcomePage()),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  firstcheck
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                            child: Container(
                              height: width / 6.5,
                              width: width / 1.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Color(0XFFa3daff),
                                  width: 3.5,
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                'アイコンをタップして始めよう！',
                                style: TextStyle(
                                  fontSize: width / 25,
                                ),
                              )),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
