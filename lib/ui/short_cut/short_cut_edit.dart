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
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'ショートカットの編集',
      ),
      body: _ShortCutList(),
    );
  }
}

class _ShortCutList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return ReorderableListView(
      children: List.generate(
        userData.shortCuts.length,
        (index) {
          return SizedBox(
            key: Key(userData.shortCuts[index][4].toString()),
            width: displaySize.width,
            child: _ShortCutItem(index: index),
          );
        },
      ),
      onReorder: (oldIndex, newIndex) {
        userData.sort(oldIndex, newIndex);
      },
    );
  }
}

class _ShortCutItem extends StatelessWidget {
  _ShortCutItem({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Row(
      children: <Widget>[
        SizedBox(
          width: displaySize.width / 70,
        ),
        Expanded(
          child: Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(
                IconData(
                  userData.categories[userData.shortCuts[index][0]][0],
                  fontFamily: 'MaterialIcons',
                ),
                color: (userData.shortCuts[index][3]) ? color : Colors.grey,
                size: displaySize.width / 12,
              ),
              title: Text(
                userData.shortCuts[index][1],
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
              trailing: Container(
                padding: EdgeInsets.all(displaySize.width / 70),
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
          color: color,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => _RemoveShortCutDialog(index: index),
            );
          },
        ),
        SizedBox(
          width: displaySize.width / 70,
        ),
      ],
    );
  }
}

class _RemoveShortCutDialog extends StatelessWidget {
  _RemoveShortCutDialog({@required this.index});
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
