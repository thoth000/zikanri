import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/register_controller.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';
import 'package:zikanri/ui/mypage.dart';
import 'package:zikanri/ui/parts/error_dialog.dart';

class FirstRegisterPage extends StatelessWidget {
  FirstRegisterPage._({Key key}) : super(key: key);
  static Widget wrapped() {
    return ChangeNotifierProvider<RegisterController>(
      create: (_) => RegisterController(),
      child: FirstRegisterPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(height: displaySize.width / 10),
          Center(
            child: Text(
              'ユーザー登録',
              style: TextStyle(
                fontSize: FontSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: displaySize.width / 10),
          _BackUp(),
          SizedBox(height: displaySize.width / 10),
          _Friend(),
          SizedBox(height: displaySize.width / 10),
          UserIDField(),
          SizedBox(height: displaySize.width / 10),
          RegisterButton(),
          Center(
            child: FlatButton(
              onPressed: () async {
                await Hive.box('userData').put('userID', '未登録');
                await Hive.box('userData').put('backUpCode', '未登録');
                List<String> favoriteIDs = [];
                await Hive.box('userData').put('favoriteIDs', favoriteIDs);
                await userData.initialize();
                await Provider.of<UsersController>(context, listen: false)
                    .getFavoriteUsers(userData.favoriteIDs);
                await Provider.of<UsersController>(context, listen: false)
                    .getFeaturedUsers();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAppPage.wrapped(),
                  ),
                );
              },
              child: Text('スキップして始める'),
            ),
          ),
          SizedBox(height: displaySize.width / 10),
        ],
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
    final RegisterController registerController =
        Provider.of<RegisterController>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: displaySize.width / 15),
      child: TextField(
        controller: userIDController,
        decoration: InputDecoration(
          hintText: 'ユーザーID',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          errorText:
              (registerController.isCanRegister || !registerController.isTap)
                  ? null
                  : registerController.message,
        ),
        onChanged: (text) {
          registerController.changeID(text);
        },
        onTap: () {
          registerController.onTap();
        },
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RegisterController registerController =
        Provider.of<RegisterController>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      margin: EdgeInsets.symmetric(horizontal: displaySize.width / 10),
      height: displaySize.width / 6.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(500),
        border: Border.all(
          color: (registerController.isCanRegister &&
                  !registerController.isLoadingID)
              ? color
              : color.withOpacity(0.5),
          width: 3,
        ),
      ),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(500),
        ),
        onPressed: (registerController.isCanRegister &&
                !registerController.isLoadingID)
            ? () async {
                final String result = await registerController.register();
                if (result == 'success') {
                  await Provider.of<UserDataNotifier>(context, listen: false)
                      .initialize();
                  final ids =
                      Provider.of<UserDataNotifier>(context, listen: false)
                          .favoriteIDs;
                  await Provider.of<UsersController>(context, listen: false)
                      .getFavoriteUsers(ids);
                  await Provider.of<UsersController>(context, listen: false)
                      .getFeaturedUsers();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyAppPage.wrapped(),
                    ),
                  );
                } else {
                  final String error = '登録できませんでした。';
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
          '無料で登録する',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _BackUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: displaySize.width / 10,
        ),
        item(),
        SizedBox(
          width: displaySize.width / 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'データの保存',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'データをオンライン上に保存できて安心',
                style: TextStyle(
                  fontSize: FontSize.small,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
      ],
    );
  }

  Widget item() {
    return Icon(
      Icons.cloud_upload,
      color: Colors.blue,
      size: displaySize.width / 5,
    );
  }
}

class _Friend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: displaySize.width / 10,
        ),
        item(),
        SizedBox(
          width: displaySize.width / 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'ユーザーと競う',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'ユーザーを見つけて価値時間のランキングを競う',
                style: TextStyle(
                  fontSize: FontSize.small,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
      ],
    );
  }

  Widget item() {
    return Icon(
      Icons.people,
      color: Colors.orange,
      size: displaySize.width / 5,
    );
  }
}
