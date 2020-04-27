import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class ProfileSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'プロフィールを編集',
          style: TextStyle(
            color: (theme.isDark) ? Colors.white : Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              await userData.editProfile();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: displaySize.width / 3,
                  width: displaySize.width / 3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: userIcon),
                  ),
                  child: FlatButton(
                    shape: CircleBorder(),
                    child: Container(),
                    onPressed: () => print('変更'),
                  ),
                ),
                FlatButton(
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                    'プロフィール画像を変更',
                    style: TextStyle(
                      fontSize: FontSize.small,
                    ),
                  ),
                  onPressed: () => print('変更'),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'ユーザー名',
              style: TextStyle(
                color: Colors.grey,
                fontSize: FontSize.xsmall,
              ),
            ),
            Container(
              height: displaySize.width / 6,
              child: TextField(
                cursorColor: (theme.isDark)
                    ? theme.themeColors[0]
                    : theme.themeColors[1],
                decoration: InputDecoration(
                  hintText: userData.userName,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: (theme.isDark)
                          ? theme.themeColors[0]
                          : theme.themeColors[1],
                    ),
                  ),
                ),
                style: TextStyle(fontSize: FontSize.small),
                onChanged: (name) {
                  userData.nameChange(name);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '自己紹介',
              style: TextStyle(
                color: Colors.grey,
                fontSize: FontSize.xsmall,
              ),
            ),
            Container(
              height: displaySize.width / 6,
              child: TextField(
                cursorColor: (theme.isDark)
                    ? theme.themeColors[0]
                    : theme.themeColors[1],
                decoration: InputDecoration(
                  hintText: userData.introduction,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: (theme.isDark)
                          ? theme.themeColors[0]
                          : theme.themeColors[1],
                    ),
                  ),
                ),
                style: TextStyle(fontSize: FontSize.small),
                onChanged: (intro) {
                  userData.introChange(intro);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'twitter ID',
              style: TextStyle(
                color: Colors.grey,
                fontSize: FontSize.xsmall,
              ),
            ),
            Container(
              height: displaySize.width / 6,
              child: TextField(
                cursorColor: (theme.isDark)
                    ? theme.themeColors[0]
                    : theme.themeColors[1],
                decoration: InputDecoration(
                  hintText: userData.twitterID,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: (theme.isDark)
                          ? theme.themeColors[0]
                          : theme.themeColors[1],
                    ),
                  ),
                ),
                style: TextStyle(fontSize: FontSize.small),
                onChanged: (id) {
                  userData.twitterChange(id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
