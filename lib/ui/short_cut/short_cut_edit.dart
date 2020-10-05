//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class ShortCutsEditPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    void deleteCheck(int index) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'ショートカットの編集',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ReorderableListView(
              children: [
                for (int i = 0; i < userData.shortCuts.length; i++)
                  SizedBox(
                    key: Key(userData.shortCuts[i][4].toString()),
                    width: displaySize.width,
                    child: Row(
                      children: <Widget>[
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Card(
                            child: ListTile(
                              leading: Icon(
                                IconData(
                                  userData.categories[userData.shortCuts[i][0]]
                                      [0],
                                  fontFamily: 'MaterialIcons',
                                ),
                                color: (userData.shortCuts[i][3])
                                    ? (theme.isDark)
                                        ? theme.themeColors[0]
                                        : theme.themeColors[1]
                                    : Colors.grey,
                                size: displaySize.width / 12,
                              ),
                              title: Text(
                                userData.shortCuts[i][1],
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
                                  (userData.shortCuts[i][5]) ? '記録' : '開始',
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
                            color: theme.isDark
                                ? theme.themeColors[0]
                                : theme.themeColors[1],
                            onPressed: () => deleteCheck(i)),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
              ],
              onReorder: (oldIndex, newIndex) =>
                  userData.sort(oldIndex, newIndex),
            ),
          ),
        ],
      ),
    );
  }
}
