//packages
import 'package:flutter/material.dart';
//my files
import 'package:zikanri/ui/lately/activity_list.dart';
import 'package:zikanri/ui/lately/day_data_list.dart';
import 'package:zikanri/config.dart';

class LatelyPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DayDataList(),
        ActivityList(),
        SizedBox(
          height: displaySize.width / 10,
        ),
      ],
    );
  }
}