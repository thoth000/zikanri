//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my file
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/data.dart';
import 'package:zikanri/lately/day_data_widget.dart';

class DayDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return SizedBox(
      height: displaySize.width / 2 + 20,
      child: PageView(
        scrollDirection: Axis.horizontal,
        onPageChanged: (i) {
          userData.setIndex(i);
        },
        controller: PageController(
          initialPage: userData.latelyData.length,
        ),
        children: <Widget>[
          for (var itemList in userData.latelyData)
            DayDataWidget(
              itemList: itemList,
            ),
        ],
      ),
    );
  }
}
