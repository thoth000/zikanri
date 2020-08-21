import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/data.dart';
import 'package:zikanri/parts/general_app_bar.dart';
import 'package:zikanri/service/auth.dart';
import 'package:zikanri/service/store_service.dart';
import 'package:zikanri/takeover/result_dialog.dart';
import 'package:zikanri/takeover/sign_in.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'データ書き込み',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: emailController,
              style: TextStyle(
                fontSize: FontSize.midium,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'メールアドレス',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                  ),
                ),
              ),
              cursorColor: color,
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty) {
                    email = '';
                  } else {
                    email = text;
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: passwordController,
              style: TextStyle(
                fontSize: FontSize.midium,
              ),
              decoration: InputDecoration(
                hintText: '6文字以上のパスワード',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                  ),
                ),
              ),
              cursorColor: color,
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty) {
                    password = '';
                  } else {
                    password = text;
                  }
                });
              },
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(
                  color: (email.isEmpty || password.length < 6)
                      ? Colors.grey
                      : color,
                  width: 3,
                ),
              ),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'データを登録する',
                        style: TextStyle(
                          fontSize: FontSize.small,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: (email.isEmpty || password.length < 6)
                    ? null
                    : () async {
                        String result =
                            await Auth().createUser(email, password);
                        if (result == 'error:exist') {
                          result = await Auth().signIn(email, password);
                        }
                        if (result == 'error:email') {
                          result = '登録無効なメールアドレスです。';
                        } else if (result == 'error:password') {
                          result = '一度設定したパスワードを使用してください。';
                        } else if (result == 'error:unknown') {
                          result = 'データの登録に失敗しました。';
                        } else {
                          final userData = Provider.of<UserDataNotifier>(
                              context,
                              listen: false);
                          final data = {
                            'name': userData.userName,
                            'passDay': userData.totalPassedDays,
                            'allTime': userData.allTime,
                            'allGood': userData.allGood,
                            'allPer': userData.allPer,
                          };
                          final upload = await StoreService()
                              .uploadData(result, data, userData.categories);
                          if (upload == 'success') {
                            result = '正常にデータを登録しました。';
                          } else {
                            result = 'データの登録に失敗しました。';
                          }
                        }
                        await showDialog(
                          context: context,
                          builder: (context) => ResultDialog(
                            message: result,
                          ),
                        );
                      },
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          FlatButton(
            child: Text(
              "データの呼び出しはこちらから",
              style: TextStyle(
                fontSize: FontSize.xsmall,
                fontWeight: FontWeight.w700,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInPage(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
