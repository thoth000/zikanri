import 'package:flutter/material.dart';

import 'home/home.dart';
import 'data.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void _startTimer() async {
    Timer(
      Duration(seconds: 4),
      () {
        Navigator.push(
          context,
          _createRoute(),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    displaySize = MediaQuery.of(context).size;
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
                      fontSize: displaySize.width / 7.5,
                    ),
                  ),
                  Text(
                    '毎日をより価値あるものに',
                    style: TextStyle(
                      fontSize: displaySize.width / 25,
                      color: Color(0XFF3A405A),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                height: displaySize.width / 2,
                width: displaySize.width / 2,
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
                child: Image.asset('images/zikanri_shaped.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}