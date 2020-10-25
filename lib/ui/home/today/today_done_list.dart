//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/home/today/today_done_widget.dart';

class TodayDoneList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final length = userData.todayDoneList.length;
    return Column(
      children: List.generate(
        length,
        (index) => TodayDoneWidget(
          index: index,
        ),
      ).reversed.toList(),
    );
  }
}
