import 'package:flutter/material.dart';
import 'package:zikanri/data.dart';
import 'package:provider/provider.dart';

class TodayWidget extends StatelessWidget {
  Widget _todayDone(context, index, userData, theme) {
    var itemList = userData.todayDoneList[index];
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Icon(
              IconData(
                int.parse(itemList[0]),
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 10,
              //カラーは価値時間ならテーマカラーを、価値なしではグレーを用いる
              color: (itemList[3])
                  ? (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1]
                  : Colors.grey,
            ),
          ),
          Container(
            width: displaySize.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemList[1],
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  itemList[2].toString() + '分',
                  style: TextStyle(
                    fontSize: FontSize.xxsmall,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.remove_circle_outline,
              ),
              iconSize: displaySize.width / 12,
              color: theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
              onPressed: () => showDialog(
                  context: context,
                  child: _deleteAlert(context, itemList, index, userData))),
        ],
      ),
    );
  }

  Widget _deleteAlert(context, itemList, index, userData) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        '記録の削除',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      content: Text('タイトル:\n' + itemList[1] + '\n\nこの記録を削除しますか？'),
      actions: <Widget>[
        FlatButton(
          child: Text('いいえ'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('はい'),
          onPressed: () {
            userData.deleteDone(itemList, index);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
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
                color:
                    theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
                width: 2),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '価値時間',
                          style: TextStyle(
                              fontSize: FontSize.midium,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Text(
                      userData.todayGood.toString() + ' ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.xxlarge,
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                ),
                Text(
                  '記録',
                  style: TextStyle(
                      fontSize: FontSize.midium, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < userData.todayDoneList.length; i++)
                  _todayDone(context, i, userData, theme),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      (userData.todayDoneList.length == 0)
                          ? displaySize.width / 10
                          : 0,
                    ),
                    child: Text(
                      (userData.todayDoneList.length == 0)
                          ? '今日の記録はまだありません'
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
