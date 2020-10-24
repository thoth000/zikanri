//packages
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
//my files
import 'package:zikanri/ui/category/category.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/ui/guide/feature_guide.dart';
import 'package:zikanri/ui/guide/quick_guide.dart';
import 'package:zikanri/ui/setting/privacy.dart';
import 'package:zikanri/ui/setting/takeover/back_up.dart';
import 'package:zikanri/ui/setting/takeover/copy.dart';
import 'package:zikanri/ui/setting/profile/profile.dart';
import 'package:zikanri/ui/short_cut/short_cut_edit.dart';
import 'package:zikanri/ui/setting/theme.dart';
import 'package:zikanri/ui/setting/achieve.dart';
import 'package:zikanri/config.dart';

class SettingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    //animation
    Route _createRoute(page) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.ease;
          final tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
    }

    final theme = Provider.of<ThemeNotifier>(context);

    return Container(
      color: theme.isDark ? null : const Color(0XFFe7ecf0),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '基本機能',
              style: TextStyle(
                fontSize: FontSize.xsmall,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: theme.isDark ? const Color(0XFF424242) : Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'ユーザ情報を確認・変更する',
                    style: TextStyle(fontSize: FontSize.xsmall),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        ProfileSettingPage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'テーマを変更する',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        ThemeSettingPage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'ショートカットを編集する',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        ShortCutsEditPage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'カテゴリーを編集する',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        CategoryPage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    '実績を確認する',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        AchievePage.wrapped(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'その他',
              style: TextStyle(
                fontSize: FontSize.xsmall,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: theme.isDark ? const Color(0XFF424242) : Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'クイックガイドを見る',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        QuickGuide(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    '機能ガイドを見る',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        FeatureGuide(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'データのバックアップ',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        BackUpPage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'データの引き継ぎ',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        CopyPage.wrapped(
                          Provider.of<UserDataNotifier>(context, listen: false)
                              .userID,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'アプリをレビューする',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    LaunchReview.launch(
                        androidAppId: 'com.thoth000.zikanri_app');
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'プライバシーポリシー',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      _createRoute(
                        PrivacyPage(),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
                ListTile(
                  title: Text(
                    'アプリデータの削除',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => _ClearDataDialog(),
                    );
                  },
                ),
                const Divider(
                  height: 0,
                ),
              ],
            ),
          ),
          SizedBox(
            height: displaySize.width / 8,
          ),
        ],
      ),
    );
  }
}

class _ClearDataDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('データの永久削除'),
      content: const Text('データを削除しますか？\n削除すると自動的にアプリが終了します。'),
      actions: <Widget>[
        FlatButton(
          child: const Text('いいえ'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: const Text('はい'),
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
