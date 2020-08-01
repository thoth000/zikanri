import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:zikanri/data.dart';
import 'package:zikanri/mypage.dart';

class UpdateNoticePage extends StatelessWidget {
  UpdateNoticePage({
    this.newVersion,
  });
  final String newVersion;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 8,
          ),
          Center(
            child: Text(
              "Ver.1.1.0",
              style: TextStyle(
                fontSize: FontSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width / 8,
          ),
          _NoticeVersion(),
          SizedBox(height: displaySize.width / 10),
          _Guide(),
          SizedBox(
            height: displaySize.width / 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: displaySize.width / 10,
            ),
            child: RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  "続ける",
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
              onPressed: () {
                Hive.box('userData').put('version', newVersion);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyAppPage.wrapped(),
                  ),
                );
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

class _NoticeVersion extends StatelessWidget {
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
                "バージョン通知",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "この画面でアップデート内容を分かりやすくお知らせします。",
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
      Icons.notifications,
      color: Colors.yellow,
      size: displaySize.width / 5,
    );
  }
}

class _Guide extends StatelessWidget {
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
                "ガイドの追加",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "アプリを始めた方に向けて丁寧なアプリガイドを用意しました。",
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
      Icons.assignment,
      color: Colors.blue,
      size: displaySize.width / 5,
    );
  }
}
