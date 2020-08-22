import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/data.dart';
import 'package:zikanri/mypage.dart';

class UpdateNoticePage extends StatelessWidget {
  const UpdateNoticePage({
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
              'Ver.1.4.0',
              style: TextStyle(
                fontSize: FontSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width / 8,
          ),
          _Cloud(),
          SizedBox(height: displaySize.width / 10),
          _Takeover(),
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
                  '続ける',
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
                await Hive.box('userData').put('version', newVersion);
                await Provider.of<UserDataNotifier>(context, listen: false)
                    .initialize();
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

class _Cloud extends StatelessWidget {
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
                'データの保存',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'ネット上にデータを保存できるようになりました。（ログイン必要）',
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
      Icons.cloud_upload,
      color: Colors.blue,
      size: displaySize.width / 5,
    );
  }
}

class _Takeover extends StatelessWidget {
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
                'データの引き継ぎ',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '他の端末にデータを引き継げるようになりました。（ログイン必要）',
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
      Icons.directions_car,
      color: Colors.green,
      size: displaySize.width / 5,
    );
  }
}
