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
          'ユーザー名の変更',
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
            Text(
              '今のユーザー名',
              style: TextStyle(
                color: Colors.grey,
                fontSize: FontSize.small,

              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              userData.userName,
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              '新しいユーザー名',
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
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: (theme.isDark)
                          ? theme.themeColors[0]
                          : theme.themeColors[1],
                    ),
                  ),
                ),
                style: TextStyle(fontSize: FontSize.midium,fontWeight: FontWeight.w700,),
                onChanged: (name) {
                  userData.nameChange(name);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
