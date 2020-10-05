import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/copy_controller.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';
import 'package:zikanri/ui/parts/error_dialog.dart';
import 'package:zikanri/ui/parts/success_dialog.dart';

class CopyPage extends StatelessWidget {
  static Widget wrapped(String nowID) {
    return ChangeNotifierProvider(
      create: (_) => CopyController(nowID: nowID),
      child: CopyPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
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
                  'データの引き継ぎ',
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
          UserIDField(),
          SizedBox(
            height: displaySize.width / 20,
          ),
          CodeField(),
          SizedBox(
            height: displaySize.width / 10,
          ),
          CopyButton(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Icon(
        Icons.cloud_download,
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
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text('データの引き継ぎ'),
      content: Text('引き継ぎには事前にオンライン上にバックアップされたデータが必要です。'),
      actions: [
        FlatButton(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}

class CopyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final CopyController copyController = Provider.of<CopyController>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: displaySize.width / 10),
      height: displaySize.width / 6.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: (copyController.checkUserID.isEmpty &&
                copyController.checkCode)
              ? themeColor
              : themeColor.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: FlatButton(
        onPressed: (copyController.checkUserID.isEmpty &&
                copyController.checkCode)
            ? () async {
                FocusScope.of(context).unfocus();
                Map<String, dynamic> user = await copyController.getCopyData();
                if (user != null) {
                  user['userID'] = copyController.userID;
                  user['backUpCode'] = copyController.code;
                  await userData.takeOver(user);
                  await Provider.of<UsersController>(context, listen: false)
                      .getFavoriteUsers(userData.favoriteIDs);
                  await Provider.of<UsersController>(context, listen: false)
                      .getFeaturedUsers();
                  final String message = 'データのコピーが完了しました。';
                  await showDialog(
                    context: context,
                    builder: (context) => SuccessDialog(
                      message: message,
                    ),
                  );
                } else {
                  final String error = 'データのコピーに失敗しました。';
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
          'コピーする',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class UserIDField extends StatefulWidget {
  @override
  _UserIDFieldState createState() => _UserIDFieldState();
}

class _UserIDFieldState extends State<UserIDField> {
  TextEditingController userIDController;
  @override
  void initState() {
    userIDController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CopyController copyController = Provider.of<CopyController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: userIDController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          labelText: 'ユーザーID',
          errorText:
              (copyController.checkUserID.isEmpty || !copyController.isTapID)
                  ? null
                  : copyController.checkUserID,
        ),
        onChanged: (text) {
          copyController.changeUserID(text);
        },
        onTap: () {
          copyController.tapID();
        },
      ),
    );
  }
}

class CodeField extends StatefulWidget {
  @override
  _CodeFieldState createState() => _CodeFieldState();
}

class _CodeFieldState extends State<CodeField> {
  TextEditingController codeController;
  @override
  void initState() {
    codeController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CopyController copyController = Provider.of<CopyController>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: codeController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          labelText: 'バックアップコード',
          errorText: (copyController.checkCode || !copyController.isTapCode)
              ? null
              : 'バックアップコードは6文字です。',
        ),
        onChanged: (text) {
          copyController.changeCode(text);
        },
        onTap: () {
          copyController.tapCode();
        },
      ),
    );
  }
}
