import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/data.dart';

class QuickGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: displaySize.width / 20,
            ),
            _RecordButton(),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              "記録ボタン",
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: displaySize.width / 50,
            ),
            Text(
              "このボタンで活動の記録を始められます。\n・既に終わった活動を記録する「記録」モード\n・これから活動を始める「開始」モード\nの二つから記録方法を選択できます。",
            ),
            Divider(
              height: displaySize.width / 6,
            ),
            _ActiveTimer(),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              "活動タイマー",
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: displaySize.width / 50,
            ),
            Text(
              "記録が「開始」モードだとタイマーが作られます。\nボタンにはそれぞれアクションがあります。\n・左ボタン　　　タイマーのスタート・ストップ\n・中央ボタン　　活動の記録\n・右ボタン　　　タイマーの削除",
            ),
            Divider(
              height: displaySize.width / 6,
            ),
            _Category(),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              "カテゴリー",
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: displaySize.width / 50,
            ),
            Text(
              "アイコンとタイトルを自由に組み合わせて作ります。\nカテゴリーは最大8個まで設定できます。\nカテゴリーごとに記録のデータを取れます。",
            ),
            Divider(
              height: displaySize.width / 6,
            ),
            Text(
              "ガイドの続き",
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: displaySize.width / 50,
            ),
            Text("Zikanriには他にも便利な機能があります。\n気になる方は設定ページの機能ガイドも見てください。"),
            SizedBox(
              height: displaySize.width / 10,
            ),
            RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "クイックガイドを閉じる",
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
            ),
            SizedBox(
              height: displaySize.width / 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ThemeNotifier>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "クイックガイド",
        style: TextStyle(
          color: controller.isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
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
        ),
      ],
    );
  }
}

class _ActiveTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(10),
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
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            "活動タイトル",
                            overflow: TextOverflow.fade,
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
                          '20分',
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
                    SizedBox(
                      height: displaySize.width / 12,
                      width: displaySize.width / 12,
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.play_circle_outline,
                            size: displaySize.width / 12,
                          ),
                          SizedBox(
                            height: displaySize.width / 12,
                            width: displaySize.width / 12,
                            child: FlatButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: SizedBox(),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: displaySize.width / 12,
                      width: displaySize.width / 12,
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.check_circle_outline,
                            size: displaySize.width / 12,
                          ),
                          SizedBox(
                            height: displaySize.width / 12,
                            width: displaySize.width / 12,
                            child: FlatButton(
                              child: SizedBox(),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: displaySize.width / 12,
                      width: displaySize.width / 12,
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.remove_circle_outline,
                            size: displaySize.width / 12,
                          ),
                          SizedBox(
                            height: displaySize.width / 12,
                            width: displaySize.width / 12,
                            child: FlatButton(
                              child: SizedBox(),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
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
    return Row(
      children: <Widget>[
        Icon(
          Icons.edit,
          size: displaySize.width / 7,
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
        Icon(
          Icons.laptop_chromebook,
          size: displaySize.width / 7,
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
        Icon(
          Icons.directions_run,
          size: displaySize.width / 7,
        ),
        SizedBox(
          width: displaySize.width / 10,
        ),
      ],
    );
  }
}