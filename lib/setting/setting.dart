import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

import '../data.dart';
import 'profile.dart';
import 'theme.dart';
import '../home/record_button.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '基本設定',
                style: TextStyle(fontSize: FontSize.small),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              height: displaySize.width / 6,
              width: displaySize.width,
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileSettingPage(),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      'プロフィールを変更',
                      style: TextStyle(
                        fontSize: FontSize.xsmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              height: displaySize.width / 6,
              width: displaySize.width,
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThemeSettingPage(),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      'テーマを変更',
                      style: TextStyle(
                        fontSize: FontSize.xsmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'データの設定',
                style: TextStyle(fontSize: FontSize.small),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              height: displaySize.width / 6,
              width: displaySize.width,
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  record.resetIconandTitle();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditCategoryPage(),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      'カテゴリーの編集',
                      style: TextStyle(
                        fontSize: FontSize.xsmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              height: displaySize.width / 6,
              width: displaySize.width,
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShortCutsEditPage(),
                    ),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      'ショートカットを編集',
                      style: TextStyle(
                        fontSize: FontSize.xsmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
            SizedBox(
              height: 100,
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            Container(
              height: displaySize.width / 6,
              width: displaySize.width,
              child: FlatButton(
                color: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => clearAlert(context));
                },
                child: Row(
                  children: <Widget>[
                    Text(
                      'アプリデータの削除',
                      style: TextStyle(
                          fontSize: FontSize.xsmall,
                          fontWeight: FontWeight.w700,
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget themeChanger(theme, i) {
    return Container(
      height: displaySize.width / 8,
      width: displaySize.width / 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: baseColors[int.parse(theme.myColors[i])],
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        color: Colors.transparent,
        child: Container(),
        onPressed: () async => await theme.changeTheme(i),
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
