//packages
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/mypage.dart';
import 'package:zikanri/config.dart';

class UpdateNoticePage extends StatelessWidget {
  const UpdateNoticePage({
    this.newVersion,
  });
  final String newVersion;
  @override
  Widget build(BuildContext context) {
    //function
    Future updateProcess() async {
      await Hive.box('userData').put('version', newVersion);
      if (newVersion == '1.6.0') {
        await Hive.box('userData').put('userID', '未登録');
        await Hive.box('userData').put('backUpCode', '未登録');
        await Hive.box('userData').put('myIcon', Icons.access_time.codePoint);
        List<String> favoriteIDs = [];
        await Hive.box('userData').put('favoriteIDs', favoriteIDs);
        await Hive.box('userData').put('backUpCanDate', DateTime.now());
      }
      await Provider.of<UserDataNotifier>(context, listen: false).initialize();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyAppPage.wrapped(),
        ),
      );
    }

    //widget
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: displaySize.width / 8,
          ),
          Center(
            child: Text(
              'Ver $newVersion',
              style: TextStyle(
                fontSize: FontSize.xlarge,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width / 8,
          ),
          _Register(),
          SizedBox(height: displaySize.width / 10),
          _Friends(),
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
                await updateProcess();
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

class _Register extends StatelessWidget {
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
                'ユーザーの登録',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'IDだけで登録ができるようになりました。',
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
      Icons.person,
      color: Colors.blue,
      size: displaySize.width / 5,
    );
  }
}

class _Friends extends StatelessWidget {
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
                '他のユーザー',
                style: TextStyle(
                  fontSize: FontSize.midium,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'ユーザー登録で他のユーザーと競えます。',
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
      Icons.people,
      color: Colors.orange,
      size: displaySize.width / 5,
    );
  }
}
