//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/home/today/add_time_sheet.dart';

class TodayDoneWidget extends StatelessWidget {
  const TodayDoneWidget({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    final List itemList = userData.todayDoneList[index];
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              IconData(
                userData.categories[itemList[0]][0],
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 10,
              color: (itemList[3]) ? color : Colors.grey,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemList[1],
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
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
            icon: const Icon(
              Icons.add_circle_outline,
            ),
            iconSize: displaySize.width / 12,
            color: color,
            onPressed: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) => AddSheet.wrapped(
                index,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.remove_circle_outline,
            ),
            iconSize: displaySize.width / 12,
            color: color,
            onPressed: () => showDialog(
              context: context,
              child: _RemoveActivityDialog(
                index: index,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RemoveActivityDialog extends StatelessWidget {
  _RemoveActivityDialog({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    final List itemList = userData.todayDoneList[index];
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        '削除',
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      content: const Text('この記録を削除しますか？'),
      actions: <Widget>[
        FlatButton(
          child: const Text('いいえ'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: const Text('はい'),
          onPressed: () {
            Vib.select();
            userData.deleteDone(itemList, index);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
