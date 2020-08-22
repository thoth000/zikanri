//packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/service/auth.dart';
import 'package:zikanri/service/store_service.dart';
import 'package:zikanri/takeover/result_dialog.dart';
import 'package:zikanri/takeover/sign_up.dart';
import 'package:zikanri/data.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String email = '';
  String password = '';
  bool isLoad = false;
  void switchLoad() {
    setState(() {
      isLoad = !isLoad;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Stack(
      children: [
        Scaffold(
          appBar: _GuideAppBar(),
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
                    hintText: 'パスワード',
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
                      color: (email.isEmpty ||
                              password.isEmpty ||
                              (Hive.box('userData')
                                      .containsKey('takeoverFinish') &&
                                  Hive.box('userData').get('takeoverFinish')))
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
                            'データを呼び出す',
                            style: TextStyle(
                              fontSize: FontSize.small,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onPressed: (email.isEmpty ||
                            password.isEmpty ||
                            (Hive.box('userData')
                                    .containsKey('takeoverFinish') &&
                                Hive.box('userData').get('takeoverFinish')) ||
                            isLoad)
                        ? null
                        : () async {
                            switchLoad();
                            String result =
                                await Auth().signIn(email, password);
                            if (result == 'error:email') {
                              result = '失敗しました。\nメールアドレスが間違っています。';
                            } else if (result == 'error:password') {
                              result = '失敗しました。\nパスワードが間違っています。';
                            } else if (result == 'error:unknown') {
                              result = '失敗しました。\nデータを呼び出せませんでした。';
                            } else {
                              List achive =
                                  await StoreService().getUserData(result);
                              await StoreService().getUserCategory(result);
                              await Provider.of<UserDataNotifier>(context,
                                      listen: false)
                                  .takeOver(achive[0], achive[1]);
                              await Provider.of<ThemeNotifier>(context,
                                      listen: false)
                                  .firstOpenDataSet();
                              result = '正常にデータを引き継ぎました。';
                              await Hive.box('userData')
                                  .put('takeoverFinish', true);
                            }
                            await Future.delayed(Duration(seconds: 1));
                            switchLoad();
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
                  "データの登録はこちらから",
                  style: TextStyle(
                    fontSize: FontSize.xsmall,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        (isLoad)
            ? Container(
                color: Colors.grey.withOpacity(0.4),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}

class _GuideAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ThemeNotifier>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'データ呼び出し',
        style: TextStyle(
          color: controller.isDark ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.help_outline,
          ),
          onPressed: () => showDialog(
            context: context,
            builder: (context) => HelpDialog(),
          ),
        ),
      ],
    );
  }
}

class HelpDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('データ呼び出し'),
      content: Text(
          'ネット上に保存したデータを呼び出すことができます。\n端末に保存されているデータは上書きされます。\nデータの呼び出しは1日1回までです。'),
      actions: [
        FlatButton(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
