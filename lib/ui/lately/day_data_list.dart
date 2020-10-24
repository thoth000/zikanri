//package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/lately_controller.dart';
//my file
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/lately/day_data_widget.dart';

class DayDataList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final controller = Provider.of<LatelyController>(context);
    final latelyData = userData.latelyData;
    return SizedBox(
      height: displaySize.width / 2 + 20,
      child: PageView(
        scrollDirection: Axis.horizontal,
        onPageChanged: (i) {
          controller.changeIndex(i);
        },
        controller: PageController(
          initialPage: controller.index,
        ),
        children: List.generate(
          latelyData.length,
          (index) {
            final dayData = latelyData[index];
            return DayDataWidget(
              itemList: dayData,
            );
          },
        ),
      ),
    );
  }
}
