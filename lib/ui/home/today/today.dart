//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/home/today/today_data_widget.dart';
import 'package:zikanri/ui/home/today/today_done_list.dart';

class TodayWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 35),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: displaySize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: color,
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(displaySize.width / 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TodayDataWidget(),
                Divider(
                  height: displaySize.width / 17,
                ),
                Text(
                  '記録',
                  style: TextStyle(
                    fontSize: FontSize.midium,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: displaySize.width / 35,
                ),
                TodayDoneList(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      (userData.todayDoneList.length == 0)
                          ? displaySize.width / 10
                          : 0,
                    ),
                    child: Text(
                      (userData.todayDoneList.length == 0)
                          ? '今日の活動を記録しよう！'
                          : '',
                      style: TextStyle(
                        fontSize: FontSize.xsmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
