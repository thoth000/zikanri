//packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/lately_controller.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/lately/activity.dart';

class ActivityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final controller = Provider.of<LatelyController>(context);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    final int index = controller.index;
    //widget
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: displaySize.width/35,),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: color,
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: displaySize.width/35,
              left: displaySize.width/17,
              right: displaySize.width/17,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: displaySize.width/35),
                Text(
                  '記録',
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Divider(
                  height: displaySize.width/70,
                ),
                _ActivityList(index: index),
                _NotifyTextWidget(index: index),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  _ActivityList({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final itemList =
        Provider.of<UserDataNotifier>(context).latelyData[index][4];
    return Column(
      children: List.generate(
        itemList.length,
        (activityIndex) {
          final acitivityData = itemList[activityIndex];
          return Activity(
            itemList: acitivityData,
          );
        },
      ),
    );
  }
}

class _NotifyTextWidget extends StatelessWidget {
  _NotifyTextWidget({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: (userData.latelyData[index][4].length == 0)
              ? displaySize.width / 7
              : 0,
        ),
        child: Text(
          (userData.latelyData[index][4].length == 0) ? 'この日の記録はありません' : '',
          style: TextStyle(
            fontSize: FontSize.xsmall,
          ),
        ),
      ),
    );
  }
}
