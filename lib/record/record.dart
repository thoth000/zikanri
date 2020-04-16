import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Home/Home.dart';
import '../data.dart';
import 'until_now.dart';

class RecordPage extends StatefulWidget {
  @override
  _RecordPageState createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  List pagelist = [UntilNow(),FromNow()];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          '記録の追加',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: <Widget>[
          _RecordButton(),
        ],
      ),
      body: PageView.builder(
        itemCount: 2,
        itemBuilder: (context,i){
          return pagelist[i];
        }
      ),
    );
  }
}

//AppBar右の記録ボタン
class _RecordButton extends StatefulWidget {
  @override
  __RecordButtonState createState() => __RecordButtonState();
}

class __RecordButtonState extends State<_RecordButton> {
  //ボタンが押された時にすること
  void _datachange(userData) {
    setState(
      () {
        userData.recordDone(['58698',title,time.toString(),rating.toInt().toString(),tmpValue.toString()]);
        title = '';
        time = 0;
        rating = 0.0;
        tmpValue = 0;
      },
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return IconButton(
      icon: Icon(
        Icons.mode_edit,
        color: Colors.white,
      ),
      onPressed: () => _datachange(userData),
    );
  }
}

class FromNow extends StatefulWidget {
  @override
  _FromNowState createState() => _FromNowState();
}

class _FromNowState extends State<FromNow> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
