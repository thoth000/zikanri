//packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/lately/activity.dart';

class ActivityList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //controller
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //value
    int index = userData.index;
    //widget
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(30),
            ),
            border: Border.all(
              color: color,
              width: 2,
            ),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Text(
                  '記録',
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Divider(
                  height: 5,
                ),
                for (int j = userData.latelyData[index][4].length - 1;
                    j >= 0;
                    j--)
                  Activity(
                    itemList: userData.latelyData[index][4][j],
                  ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: (userData.latelyData[index][4].length == 0)
                          ? displaySize.width / 7
                          : 0,
                    ),
                    child: Text(
                      (userData.latelyData[index][4].length == 0)
                          ? 'この日の記録はありません'
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
