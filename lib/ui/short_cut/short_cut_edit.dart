//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';

class ShortCutsEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'ショートカットの編集',
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ReorderableListView(
              children: List.generate(userData.shortCuts.length, (index) {
                return SizedBox(
                  key: Key(userData.shortCuts[index][4].toString()),
      width: displaySize.width,
                  child: ShortCutItem(index: index),
                );
              }),
              onReorder: (oldIndex, newIndex) =>
                  userData.sort(oldIndex, newIndex),
            ),
          ),
        ],
      ),
    );
  }
}

class ShortCutItem extends StatelessWidget {
  ShortCutItem({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Card(
            child: ListTile(
              leading: Icon(
                IconData(
                  userData.categories[userData.shortCuts[index][0]][0],
                  fontFamily: 'MaterialIcons',
                ),
                color: (userData.shortCuts[index][3])
                    ? (theme.isDark)
                        ? theme.themeColors[0]
                        : theme.themeColors[1]
                    : Colors.grey,
                size: displaySize.width / 12,
              ),
              title: Text(
                userData.shortCuts[index][1],
                overflow: TextOverflow.fade,
                softWrap: false,
              ),
              trailing: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300],
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  (userData.shortCuts[index][5]) ? '記録' : '開始',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.remove_circle_outline,
          ),
          iconSize: displaySize.width / 12,
          color: theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => RemoveShortCutDialog(index: index),
            );
          },
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}

class RemoveShortCutDialog extends StatelessWidget {
  RemoveShortCutDialog({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('削除'),
      content: const Text('ショートカットを削除しますか？'),
      actions: <Widget>[
        FlatButton(
          child: const Text('いいえ'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('はい'),
          onPressed: () {
            userData.deleteShortCut(index);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
