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
          SizedBox(
            height: displaySize.width / 35,
          ),
          _MyIconWidget(
            themeColor: color,
          ),
          _NameListTile(),
          _UserIDListTile(),
          _BackUpCodeListTile(),
        ],
      ),
    );
  }
}

class _MyIconWidget extends StatelessWidget {
  _MyIconWidget({@required this.themeColor});
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
                        builder: (context) => ChangeMyIconPage.wrapped(
                          beforeIcon: userData.myIcon,
                        ),
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
                builder: (context) => ChangeMyIconPage.wrapped(
                  beforeIcon: userData.myIcon,
                ),
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

class _NameListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return ListTile(
      title: Text(
        '名前',
        style: TextStyle(
          fontSize: FontSize.small,
        ),
      ),
      subtitle: Text(
        userData.userName,
        style: TextStyle(
          fontSize: FontSize.xsmall,
        ),
      ),
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

class _UserIDListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return ListTile(
      title: Text(
        'ユーザーID',
        style: TextStyle(
          fontSize: FontSize.small,
        ),
      ),
      subtitle: Text(
        '@' + userData.userID,
        style: TextStyle(
          fontSize: FontSize.xsmall,
        ),
      ),
      onTap: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('この情報は変更できません。'),
            duration: Duration(
              milliseconds: 800,
            ),
          ),
        );
      },
    );
  }
}

class _BackUpCodeListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return ListTile(
      title: Text(
        'バックアップコード',
        style: TextStyle(
          fontSize: FontSize.small,
        ),
      ),
      subtitle: Text(
        userData.backUpCode,
        style: TextStyle(
          fontSize: FontSize.xsmall,
        ),
      ),
      onTap: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('この情報は変更できません。'),
            duration: Duration(
              milliseconds: 800,
            ),
          ),
        );
      },
    );
  }
}
