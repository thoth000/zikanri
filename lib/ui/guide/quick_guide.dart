//packages
import 'package:flutter/material.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';

class QuickGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'クイックガイド',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: displaySize.width / 20,
            ),
            _RecordButton(),
            Divider(
              height: displaySize.width / 6,
            ),
            _ActiveTimer(),
            Divider(
              height: displaySize.width / 6,
            ),
            _Category(),
            Divider(
              height: displaySize.width / 6,
            ),
            _GuideIntroduction(),
            SizedBox(
              height: displaySize.width / 10,
            ),
            _ClosePageButton(),
            SizedBox(
              height: displaySize.width / 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          '記録ボタン',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
          'このボタンで活動の記録を始められます。\n・既に終わった活動を記録する「記録」モード\n・これから活動を始める「開始」モード\n二種類から記録方法を選択できます。',
        ),
      ],
    );
  }

  Widget image() {
    return Container(
      height: displaySize.width / 5,
      width: displaySize.width / 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: baseColors[0]),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.access_time,
          color: Colors.white,
          size: displaySize.width / 7,
        ),
      ),
    );
  }
}

class _ActiveTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          '活動タイマー',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
          '記録が「開始」モードだとタイマーが作られます。\nボタンにはそれぞれアクションがあります。\n・左ボタン　　　タイマーのスタート・ストップ\n・中央ボタン　　活動の記録\n・右ボタン　　　タイマーの削除',
        ),
      ],
    );
  }

  Widget image() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: displaySize.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(displaySize.width/35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: displaySize.width / 10,
              width: displaySize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: displaySize.width / 1.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          size: displaySize.width / 10,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: displaySize.width/35
                        ),
                        Flexible(
                          child: Text(
                            '活動タイトル',
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: FontSize.small,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '30分',
                          style: TextStyle(fontSize: FontSize.midium),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: displaySize.width / 36,
            ),
            Padding(
              padding: EdgeInsets.only(left: displaySize.width / 125),
              child: SizedBox(
                width: displaySize.width / 2.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.play_circle_outline,
                      color: Colors.blue,
                      size: displaySize.width / 12,
                    ),
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.blue,
                      size: displaySize.width / 12,
                    ),
                    Icon(
                      Icons.remove_circle_outline,
                      color: Colors.blue,
                      size: displaySize.width / 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          'カテゴリー',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
          'アイコンとタイトルを自由に組み合わせて作ります。\nカテゴリーは最大8個まで設定できます。\nカテゴリーごとに記録のデータを取れます。',
        ),
      ],
    );
  }

  Widget image() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.edit,
          color: Colors.blue,
          size: displaySize.width / 7,
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
        Icon(
          Icons.laptop_chromebook,
          color: Colors.blue,
          size: displaySize.width / 7,
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
        Icon(
          Icons.directions_run,
          color: Colors.blue,
          size: displaySize.width / 7,
        ),
      ],
    );
  }
}

class _GuideIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ガイドの続き',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text('Zikanriには他にも便利な機能があります。\n気になる方は設定ページの機能ガイドも見てください。'),
      ],
    );
  }
}

class _ClosePageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.all(displaySize.width/35),
        child: Text(
          'クイックガイドを閉じる',
          style: TextStyle(
            color: Colors.white,
            fontSize: FontSize.small,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
