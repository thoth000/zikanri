import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'total_score.dart';
import 'minute_meter.dart';
import '../data.dart';
import 'this_month.dart';
import 'today.dart';
import '../setting/tutorial.dart';

class HomePage extends StatelessWidget {
  final String today = DateFormat('yyyy年MM月dd日現在').format(DateTime.now());
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        TotalScoreWidget(),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        _HomeTutorial(),
        MinuteMeter(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '今月の情報',
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                today,
                style: TextStyle(
                  fontSize: FontSize.xxsmall,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        TMWidget(),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(
                '今日の情報',
                style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                today,
                style: TextStyle(
                  fontSize: FontSize.xxsmall,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        TodayWidget(),
        SizedBox(
          height: displaySize.width / 10,
          width: displaySize.width,
        ),
      ],
    );
  }
}

class _HomeTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isTutorialFinished =
        Provider.of<UserDataNotifier>(context).tutorial[0];
    if (isTutorialFinished) {
      return SizedBox();
    } else {
      return HomeTutorial();
    }
  }
}
