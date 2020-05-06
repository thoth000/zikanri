import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../welcome.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'チュートリアル',
          style: TextStyle(color: theme.isDark ? Colors.white : Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(
            height: displaySize.width / 6,
            width: displaySize.width,
            child: FlatButton(
              color: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '　アプリの説明',
                    style: TextStyle(
                      fontSize: FontSize.xsmall,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: displaySize.width / 20,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(
            height: 20,
          ),
          HomeTutorial(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
            child: RecordTutorial(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
            child: StartTutorial(),
          ),
          LatelyTutorial(),
          PreviousTutorial(),
          ShortCutEditTutorial(),
        ],
      ),
    );
  }
}

class HomeTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 20),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                Text(
                  'ホーム',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    await userData.finishTutorial(0);
                  },
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              '主な情報を見ることができます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '画面下中央にあるボタンをタップ',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              'すると活動を記録できます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '長押しすると素早く記録できる',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              'ショートカットを開けます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
          ],
        ),
      ),
    );
  }
}

class RecordTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                Text(
                  '記録の追加',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    await userData.finishTutorial(1);
                  },
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              'タイトル・時間・価値・カテゴリーを',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '決めて活動を記録します。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '記録のとき長押しすると記録すると同時に',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              'ショートカットにも追加できます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
          ],
        ),
      ),
    );
  }
}

class StartTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                Text(
                  '記録の開始',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    await userData.finishTutorial(2);
                  },
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              'タイトルとカテゴリーを決めて',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '活動を開始します。時間と時間価値は',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '活動が終わってから決定します。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '開始のとき長押しすると記録すると同時に',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              'ショートカットにも追加できます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
          ],
        ),
      ),
    );
  }
}

class LatelyTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 20),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                Text(
                  '最近の記録',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    await userData.finishTutorial(3);
                  },
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              '今日を含めた最大2週間の記録を',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '振り返ることができます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '日別のデータをSNSに共有できます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
          ],
        ),
      ),
    );
  }
}

class PreviousTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 20),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                Text(
                  '今までの記録',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    await userData.finishTutorial(4);
                  },
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              '今までの記録をカテゴリーに分けて',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '振り返ることができます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              'カテゴリーをタップしてみてください。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ShortCutEditTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(displaySize.width / 20),
      child: Card(
        elevation: 3,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                Text(
                  'ショートカットの編集',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    await userData.finishTutorial(5);
                  },
                ),
              ],
            ),
            Divider(
              height: 1,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              'ショートカットを長押しすることで',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '並び替えができます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              'ショートカットの削除は',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            Text(
              '一番右のボタンでそれぞれ行えます。',
              style: TextStyle(fontSize: FontSize.xsmall),
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
          ],
        ),
      ),
    );
  }
}
