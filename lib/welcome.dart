import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'data.dart';
import 'mypage.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);

    Future makeDir() async {
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
      await userDataBox.put('tutorial',[false,false,false,false,false,false,false,false,false]);
      await userDataBox.put('myColors', [true,true,true,false,false,false,false,false,false,false,false,false,false,false]);
      await userDataBox.put('checkM', [false,false,false,false,false]);
      await userDataBox.put('checkD', [true,false,false,false,false]);
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

    Widget welcomeBody() {
      return IntroductionScreen(
        skipFlex: 5,
        dotsFlex: 6,
        nextFlex: 5,
        pages: [
          PageViewModel(
            image: Center(
              child: /*Image(
                image: AssetImage('images/1.png'),
                height: displaySize.width / 2,
              ),*/
              SvgPicture.asset(
                'images/1.svg',
                height: displaySize.width/2,
              ),
            ),
            title: 'ジカンリへようこそ！',
            //body: 'ジカンリでは毎日の行動を価値のアリ・ナシで二種類に分けて記録できます。',
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  '毎日の行動を価値アリ・ナシの',
                  style: TextStyle(fontSize: FontSize.small),
                ),
                Text(
                  '２種類に分けて記録できます。',
                  style: TextStyle(fontSize: FontSize.small),
                ),
              ],
            ),
          ),
          PageViewModel(
            image: Center(
              child: /*Image(
                image: AssetImage('images/2.png'),
                height: displaySize.width / 2,
              ),*/
              SvgPicture.asset(
                'images/2.svg',
                height: displaySize.width/2,
              ),
            ),
            title: '記録をデータ化',
            //body: 'あなたの行動を数値やグラフを通して振り返ることができます。',
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  '記録を数値化・グラフ化して',
                  style: TextStyle(fontSize: FontSize.small),
                ),
                Text(
                  '振り返ることができます。',
                  style: TextStyle(fontSize: FontSize.small),
                ),
              ],
            ),
          ),
          PageViewModel(
            image: Center(
              child: /*Image(
                image: AssetImage('images/3.png'),
                height: displaySize.width / 2,
              ),*/
              SvgPicture.asset(
                'images/3.svg',
                height: displaySize.width/2,
              ),
            ),
            title: 'カテゴリーに分けて記録',
            //body: '豊富なアイコンと自由なタイトルから行動のカテゴリーを作成できます。',
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  '豊富なアイコンと自由なタイトルで',
                  style: TextStyle(fontSize: FontSize.small),
                ),
                Text(
                  'カテゴリーを作成できます。',
                  style: TextStyle(fontSize: FontSize.small),
                ),
              ],
            ),
          ),
          PageViewModel(
            image: Center(
              child: /*Image(
                image: AssetImage('images/4.png'),
                height: displaySize.width / 2,
              ),*/
              SvgPicture.asset(
                'images/4.svg',
                height: displaySize.width/2,
              ),
            ),
            title: 'あなたの記録をシェア',
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  'SNSで記録をシェアできます。',
                  style: TextStyle(fontSize: FontSize.small),
                ),
                Text(
                  '新しい仲間を見つけましょう！',
                  style: TextStyle(fontSize: FontSize.small),
                ),
              ],
            ),
          ),
          PageViewModel(
            image: Center(
              child: /*Image(
                image: AssetImage('images/5.png'),
                height: displaySize.width / 2,
              ),*/
              SvgPicture.asset(
                'images/5.svg',
                height: displaySize.width/2,
              ),
            ),
            title: 'ジカンリを始めよう',
            //body: '自分自身で自分の時間価値を高めましょう！',
            bodyWidget: Column(
              children: <Widget>[
                Text(
                  '自分で自分の時間価値を高めよう！',
                  style: TextStyle(
                    fontSize: FontSize.small,
                  ),
                ),
                Text(
                  'さぁ今すぐに！',
                  style: TextStyle(
                    fontSize: FontSize.small,
                  ),
                ),
              ],
            ),
          ),
        ],
        showSkipButton: true,
        showNextButton: true,
        skip: Text(
          'スキップ',
          style: TextStyle(
            fontSize: FontSize.xsmall,
            color: Colors.blue,
          ),
        ),
        next: Text(
          '次へ',
          style: TextStyle(
            fontSize: FontSize.xsmall,
            color: Colors.blue,
          ),
        ),
        done: Text(
          '始める',
          style: TextStyle(
            fontSize: FontSize.xsmall,
            color: Colors.blue,
          ),
        ),
        onDone: () async {
          Hive.box('userData').containsKey('welcome')
              ? Navigator.pop(context)
              : await makeDir();
        },
      );
    }

    return Scaffold(
      body: welcomeBody(),
    );
  }
}
