import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'data.dart';
import 'mypage.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({this.version});
  final String version;
  @override
  Widget build(BuildContext context) {
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
      // userData
      await userDataBox.put('welcome', "Yey!");
      await userDataBox.put('version', version);
      await userDataBox.put('readGuide', false);
      await userDataBox.put('myColors', [
        true,
        true,
        true,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false
      ]);
      await userDataBox.put('checkM', [false, false, false, false, false]);
      await userDataBox.put('checkD', [true, false, false, false, false]);
      /*userValue=[
        aTime,aGood,aPer,
        tmTime,tmGood,tmPer,
        tTime,tGood,tPer
      ]*/
      await userDataBox.put('userValue', [0, 0, 0, 0, 0, 0, 0, 0, 0]);
      //latelyData=[date,totaltime,goodtime,percent,donelist]
      await userDataBox.put('latelyData', [
        [firstdate, 0, 0, 0, []],
      ]);
      await userDataBox.put('todayDoneList', []);
      //shortcut=[icon,title,time,isGood,keynum,isRecord]
      await userDataBox.put(
        'shortCuts',
        [
          [0, '二度寝', 120, false, 3, true],
          [0, 'ひと狩り', 0, false, 4, false],
        ],
      );
      //category=[iconNumber,title,data[total,good,percent]]
      await userDataBox.put(
        'categories',
        [
          [
            57746,
            "指定なし",
            [0, 0, 0]
          ],
          [
            57746,
            "",
            [0, 0, 0]
          ],
          [
            57746,
            "",
            [0, 0, 0]
          ],
          [
            57746,
            "",
            [0, 0, 0]
          ],
          [
            57746,
            "",
            [0, 0, 0]
          ],
          [
            57746,
            "",
            [0, 0, 0]
          ],
          [
            57746,
            "",
            [0, 0, 0]
          ],
          [
            57746,
            "",
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
      await theme.initialize();
      await userData.initialize();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyAppPage(),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 8,
          ),
          Center(
            child: Text(
              "Zikanriへようこそ",
              style: TextStyle(
                fontSize: FontSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width / 8,
          ),
          _TimeValue(),
          SizedBox(height: displaySize.width / 20),
          _Category(),
          SizedBox(
            height: displaySize.width / 20,
          ),
          _Theme(),
          SizedBox(
            height: displaySize.width / 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: displaySize.width / 10,
            ),
            child: RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "始める",
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                makeDir();
              },
            ),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
        ],
      ),
    );
  }
}

class _TimeValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: displaySize.width / 10,
        ),
        item(),
        SizedBox(
          width: displaySize.width / 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "時間の価値",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "価値アリと価値ナシの２種類の記録しか記録できません。",
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
    return Container(
      height: displaySize.width / 5.5,
      width: displaySize.width / 5.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue,
          width: 3,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.trending_up,
          color: Colors.blue,
          size: displaySize.width / 7,
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: displaySize.width / 10,
        ),
        item(),
        SizedBox(
          width: displaySize.width / 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "カテゴリー",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "豊富なアイコンと自由なタイトルで記録を管理します。",
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
    return Container(
      height: displaySize.width / 3,
      width: displaySize.width / 5.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(
            Icons.edit,
            size: displaySize.width / 7,
            color: Colors.red,
          ),
          Icon(
            Icons.videogame_asset,
            size: displaySize.width / 7,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _Theme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: displaySize.width / 10,
        ),
        item(),
        SizedBox(
          width: displaySize.width / 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "テーマ",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "最大12種類のテーマから自分に合ったものを選べます。",
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
    return Container(
      height: displaySize.width / 5.5,
      width: displaySize.width / 5.5,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                height: displaySize.width / 11,
                width: displaySize.width / 11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                  ),
                  color: Colors.blue,
                ),
              ),
              Container(
                height: displaySize.width / 11,
                width: displaySize.width / 11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                  ),
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                height: displaySize.width / 11,
                width: displaySize.width / 11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                  ),
                  color: Colors.yellow,
                ),
              ),
              Container(
                height: displaySize.width / 11,
                width: displaySize.width / 11,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                  ),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
