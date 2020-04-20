import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import '../data.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '設定',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Card(
              child: Wrap(
                children: <Widget>[
                  for (int i = 0; i < theme.myColors.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: themeChanger(theme, i),
                    ),
                ],
              ),
            ),
          ),
          RaisedButton(
            color: Colors.red,
            onPressed: () => showDialog(context: context,child:clearAlert(context))
          ),
        ],
      ),
    );
  }

  Widget themeChanger(theme, i) {
    return Container(
      height: displaySize.width / 8,
      width: displaySize.width / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient:
            LinearGradient(colors: baseColors[int.parse(theme.myColors[i])],),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.transparent,
        child: Container(),
        onPressed: () async=> await theme.changeTheme(i),
      ),
    );
  }

  Widget clearAlert(BuildContext context) {
    return AlertDialog(
      title: Text('データの永久削除'),
      content: Text('データを削除しますか？\n削除すると自動的にアプリが終了します。'),
      actions: <Widget>[
        FlatButton(
          child: Text('いいえ'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: Text('はい'),
          onPressed: () {
            Hive.box('theme').clear();
            Hive.box('userData').clear();
            SystemNavigator.pop();
          },
        ),
      ],
    );
  }
}
