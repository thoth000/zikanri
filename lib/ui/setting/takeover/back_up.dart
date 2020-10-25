//packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/service/firebase_back_up_service.dart';
import 'package:zikanri/ui/parts/error_dialog.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';
import 'package:zikanri/ui/parts/success_dialog.dart';
import 'package:zikanri/ui/register/after_register.dart';

class BackUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    if (userData.userID == '未登録') {
      return Scaffold(
        appBar: GeneralAppBar(pageTitle: 'この機能は登録が必要です'),
        body: AfterRegisterPage.wrapped(),
      );
    }
    return Scaffold(
      appBar: _GuideAppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: displaySize.width / 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: displaySize.width / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'データのバックアップ',
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
          _UserIDField(),
          SizedBox(
            height: displaySize.width / 20,
          ),
          _CodeField(),
          SizedBox(
            height: displaySize.width / 10,
          ),
          _BackUpButton(),
        ],
      ),
    );
  }
}

class _GuideAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Icon(
        Icons.cloud_upload,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.help_outline,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => _HelpDialog(),
          ),
        ),
      ],
    );
  }
}

class _HelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final String date = DateFormat('yyyy年M月d日').format(userData.backUpCanDate);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        userData.backUpCanDate.difference(DateTime.now()).isNegative
            ? 'バックアップ可能'
            : 'バックアップ不可',
      ),
      content: Text('$dateからバックアップが可能です。'),
      actions: [
        FlatButton(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class _BackUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: displaySize.width / 10),
      height: displaySize.width / 6.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: (userData.backUpCanDate.difference(DateTime.now()).isNegative)
              ? themeColor
              : themeColor.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: FlatButton(
        onPressed:
            (userData.backUpCanDate.difference(DateTime.now()).isNegative)
                ? () async {
                    String userID = userData.userID;
                    final Map<String, dynamic> data = {
                      'userID': userID,
                      'backUpCode': userData.backUpCode,
                      'name': userData.userName,
                      'passDay': userData.totalPassedDays,
                      'allTime': userData.allTime,
                      'allGood': userData.allGood,
                      'allPer': userData.allPer,
                    };
                    //ネットワーク処理
                    final String result = await FirebaseBackUpService()
                        .uploadData(userID, data, userData.categories);
                    if (result == 'success') {
                      await userData.changeBackUpCanDate();
                      final String message =
                          'データのバックアップが完了しました。次のバックアップは1ヶ月後に可能です。';
                      await showDialog(
                        context: context,
                        builder: (context) => SuccessDialog(
                          message: message,
                        ),
                      );
                    } else {
                      final String error = 'データのバックアップに失敗しました。';
                      await showDialog(
                        context: context,
                        builder: (context) => ErrorDialog(
                          error: error,
                        ),
                      );
                    }
                  }
                : null,
        child: Text(
          'バックアップする',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _UserIDField extends StatefulWidget {
  @override
  __UserIDFieldState createState() => __UserIDFieldState();
}

class __UserIDFieldState extends State<_UserIDField> {
  TextEditingController userIDController;
  @override
  void initState() {
    userIDController = TextEditingController(
      text: Provider.of<UserDataNotifier>(context, listen: false).userID,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: displaySize.width / 25,
      ),
      child: TextField(
        controller: userIDController,
        decoration: InputDecoration(
          labelText: 'ユーザーID',
          labelStyle: TextStyle(
            color: themeColor,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: displaySize.width / 35,
            horizontal: displaySize.width / 35,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
        ),
        readOnly: true,
        onTap: () {},
      ),
    );
  }
}

class _CodeField extends StatefulWidget {
  @override
  __CodeFieldState createState() => __CodeFieldState();
}

class __CodeFieldState extends State<_CodeField> {
  TextEditingController codeController;
  @override
  void initState() {
    codeController = TextEditingController(
      text: Provider.of<UserDataNotifier>(context, listen: false).backUpCode,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: displaySize.width / 25,
      ),
      child: TextField(
        controller: codeController,
        decoration: InputDecoration(
          labelText: 'バックアップコード',
          labelStyle: TextStyle(
            color: themeColor,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: displaySize.width / 35,
            horizontal: displaySize.width / 35,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: themeColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
        ),
        readOnly: true,
      ),
    );
  }
}
