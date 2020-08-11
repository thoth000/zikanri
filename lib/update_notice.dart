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
              "Ver.1.2.0",
              style: TextStyle(
                fontSize: FontSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width / 8,
          ),
          _Review(),
          SizedBox(height: displaySize.width / 10),
          _Vibration(),
          SizedBox(
            height: displaySize.width / 10,
          ),
          _Category(),
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
                Hive.box('userData').put('categoryView', [
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                  true,
                ]);
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

class _Review extends StatelessWidget {
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
                "アプリからレビュー",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "皆さんのレビューがアプリの向上に役立ちます。",
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
      color: Colors.yellow,
      size: displaySize.width / 5,
    );
  }
}

class _Vibration extends StatelessWidget {
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
                "デバイスの振動",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "ショートカット追加時の振動を分かりやすく区別しました。",
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
      Icons.vibration,
      color: Colors.blue,
      size: displaySize.width / 5,
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
          width: displaySize.width / 20,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "カテゴリーの機能",
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "カテゴリー非表示の設定を新しく作成しました。",
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
      Icons.category,
      color: Colors.green,
      size: displaySize.width / 5,
    );
  }
}
