import 'dart:async';
//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
//my files
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/activity/activity_card.dart';
import 'package:zikanri/ui/splash.dart';

class MinuteMeter extends StatefulWidget {
  @override
  _MinuteMeterState createState() => _MinuteMeterState();
}

class _MinuteMeterState extends State<MinuteMeter> {
  //function
  void initState() {
    super.initState();
    Future(() async {
      await dateCheck();
      await loopReflesh();
    });
  }

  Future dateCheck() async {
    var now = DateTime.now();
    if (DateFormat('yyyy年MM月dd日').format(now) !=
        Hive.box('userData').get('previousDate')) {
      showDialog(
        barrierDismissible: false,
        context: (context),
        builder: (context) => _DateCheckDialog(),
      );
      await Future.delayed(
        Duration(
          milliseconds: 1500,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SplashPage(),
        ),
      );
    }
  }

  Future loopReflesh() async {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    await userData.loopReflesh();
    Timer.periodic(
      Duration(seconds: 10),
      (t) => userData.loopReflesh(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _IntroduceAcitivityText(),
        _ActivityList(),
      ],
    );
  }
}

class _DateCheckDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('日付が変わっています'),
      content: Text('自動的にタイトル画面に戻ります'),
    );
  }
}

class _IntroduceAcitivityText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    if (userData.activities.length == 0) {
      return const SizedBox();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            '今の活動',
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Column(
      children: List.generate(
        userData.activities.length,
        (index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: 5,
              left: 10,
              right: 10,
            ),
            child: ActivityCard(
              index: index,
            ),
          );
        },
      ),
    );
  }
}
