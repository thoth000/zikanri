//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/lately_controller.dart';
//my files
import 'package:zikanri/ui/lately/activity_list.dart';
import 'package:zikanri/ui/lately/day_data_list.dart';
import 'package:zikanri/config.dart';

class LatelyPage extends StatelessWidget {
  LatelyPage._();
  static Widget wrapped(int length) {
    return ChangeNotifierProvider(
      create: (_) => LatelyController(length),
      child: LatelyPage._(),
    );
  }

  @override
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
