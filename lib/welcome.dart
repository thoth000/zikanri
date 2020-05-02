import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'mypage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reload = Provider.of<ReloadNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);

    void makeDir() async {
      //アプリ初回起動時の動作
      var firstdate = DateFormat("yyyy年MM月dd日").format(DateTime.now());
      var firstMonth = DateFormat("MM").format(DateTime.now());
      var themeBox = Hive.box('theme');
      var userDataBox = Hive.box('userData');
      // theme
      await themeBox.put('isDark', false);
      await themeBox.put('themeColorsIndex', 0);
      await themeBox.put('myColors', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      // userData
      await userDataBox.put('welcome', "Yey!");
      /*userValue=[
        aTime,aGood,aPer,
        tmTime,tmGood,tmPer,
        tTime,tGood,tPer
      ]*/
      await userDataBox.put('userValue', [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      await userDataBox.put('latelyData', [
        [firstdate, 0, 0, 0, []],
      ]);
      await userDataBox.put('todayDoneList', []);
      await userDataBox.put(
        'shortCuts',
        [
          [1, '受験勉強', 60, true, 1],
          [2, '二度寝', 120, false, 2],
          [4, 'ひと狩り', 120, false, 3],
          [5, 'バスケ', 240, true, 4],
        ],
      );
      await userDataBox.put(
        'categories',
        [
          [
            57746,
            "指定なし",
            [0, 0, 0]
          ],
          [
            57680,
            "勉強",
            [0, 0, 0]
          ],
          [
            59601,
            "生活",
            [0, 0, 0]
          ],
          [
            57519,
            "仕事",
            [0, 0, 0]
          ],
          [
            58368,
            "指定1",
            [0, 0, 0]
          ],
          [
            58369,
            "指定2",
            [0, 0, 0]
          ],
          [
            58363,
            "指定3",
            [0, 0, 0]
          ],
          [
            58365,
            "指定4",
            [0, 0, 0]
          ],
        ],
      );
      await userDataBox.put('keynum', 5);
      await userDataBox.put('activities', []);
      await userDataBox.put('userName', 'ゲスト');
      await userDataBox.put('previousDate', firstdate);
      await userDataBox.put('thisMonth', firstMonth);
      await userDataBox.put('passedDays', 1);
      await userDataBox.put('totalPassedDays', 1);
      theme.initialize();
      userData.initialize();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              height: 30,
              width: 50,
              child: FlatButton(
                color: Colors.green,
                onPressed: () async {
                  reload.reloded();
                  makeDir();
                  Timer(Duration(milliseconds: 2000), reload.finishload);
                  Timer(Duration(milliseconds: 2500), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAppPage(),
                      ),
                    );
                  });
                },
                child: Container(),
              ),
            ),
          ),
          Center(
            child: (reload.reload)
                ? Container(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
