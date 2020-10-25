//packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class Activity extends StatelessWidget {
  Activity({this.itemList});
  final List itemList;
  @override
  Widget build(BuildContext context) {
    //controller
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    //style
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    //widget
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: displaySize.width/35,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            IconData(
              userData.categories[itemList[0]][0],
              fontFamily: 'MaterialIcons',
            ),
            size: displaySize.width / 12,
            color: (itemList[3]) ? color : Colors.grey,
          ),
          SizedBox(
            width: displaySize.width/35,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    itemList[1], //タイトル
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: FontSize.midium,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  width: displaySize.width/35,
                ),
                Text(
                  itemList[2].toString() + '分',
                  style: TextStyle(
                    fontSize: FontSize.xsmall,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
