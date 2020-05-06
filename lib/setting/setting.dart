import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

import '../data.dart';
import 'profile.dart';
import 'theme.dart';
import 'tutorial.dart';
import '../home/record_button.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    Route _createRoute(page) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    return Padding(
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
          SizedBox(
            height: displaySize.width / 6,
            width: displaySize.width,
            child: FlatButton(
              color: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(
                    ProfileSettingPage(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'ユーザー名を変更',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          SizedBox(
            height: displaySize.width / 6,
            width: displaySize.width,
            child: FlatButton(
              color: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(
                    ThemeSettingPage(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'テーマを変更',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
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
          SizedBox(
            height: displaySize.width / 6,
            width: displaySize.width,
            child: FlatButton(
              color: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(
                    ShortCutsEditPage(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'ショートカットを編集',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          SizedBox(
            height: displaySize.width / 6,
            width: displaySize.width,
            child: FlatButton(
              color: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(
                    CategoryEditPage(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'カテゴリーを編集',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
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
          Divider(
            height: 1,
            thickness: 1,
          ),
          SizedBox(
            height: displaySize.width / 6,
            width: displaySize.width,
            child: FlatButton(
              color: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  _createRoute(
                    TutorialPage(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'チュートリアルを見る',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
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
          Divider(
            height: 1,
            thickness: 1,
          ),
          SizedBox(
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
          SizedBox(
            height: displaySize.width / 10,
          ),
        ],
      ),
    );
  }

  Widget clearAlert(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
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
