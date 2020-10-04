//packagea
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/config.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';
import 'package:zikanri/ui/setting/profile/change_my_icon.dart';
import 'package:zikanri/ui/setting/profile/change_name_sheet.dart';

class ProfileSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'ユーザー情報',
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          MyIconWidget(
            themeColor: color,
          ),
          NameListTile(),
          UserIDListTile(),
          BackUpCodeListTile(),
        ],
      ),
    );
  }
}

class UserIDListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return ListTile(
      title: Text('ユーザーID'),
      subtitle: Text('@' + userData.userID),
      onTap: () {},
    );
  }
}

class BackUpCodeListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return ListTile(
      title: Text('バックアップコード'),
      subtitle: Text(userData.backUpCode),
      onTap: () {},
    );
  }
}

class NameListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return ListTile(
      title: Text('名前'),
      subtitle: Text(userData.userName),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => ChangeNameSheet(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
        );
      },
    );
  }
}

class MyIconWidget extends StatelessWidget {
  MyIconWidget({@required this.themeColor});
  final Color themeColor;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: displaySize.width / 4,
          width: displaySize.width / 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: themeColor,
              width: 5,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  IconData(
                    userData.myIcon,
                    fontFamily: 'MaterialIcons',
                  ),
                  size: displaySize.width / 6,
                  color: themeColor,
                ),
              ),
              SizedBox(
                height: displaySize.width / 4,
                width: displaySize.width / 4,
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeMyIconPage(),
                      ),
                    );
                  },
                  child: SizedBox(),
                ),
              ),
            ],
          ),
        ),
        FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeMyIconPage(),
              ),
            );
          },
          child: Text(
            'アイコンを変更する',
            style: TextStyle(
              color: themeColor,
            ),
          ),
        ),
      ],
    );
  }
}
