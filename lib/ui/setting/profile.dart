//packagea
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class ProfileSettingPage extends StatelessWidget {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    Color color = theme.isDark ? theme.themeColors[0] : theme.themeColors[1];
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
            icon: const Icon(Icons.check),
            onPressed: () async {
              await userData.editProfile(nameController.text);
              nameController.clear();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Text(
              '今のユーザー名',
              style: TextStyle(
                color: Colors.grey,
                fontSize: FontSize.small,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              userData.userName,
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              '新しいユーザー名',
              style: TextStyle(
                color: Colors.grey,
                fontSize: FontSize.xsmall,
              ),
            ),
            SizedBox(
              height: displaySize.width / 6,
              child: TextField(
                controller: nameController,
                maxLength: 94,
                cursorColor: color,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: color,
                    ),
                  ),
                ),
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
