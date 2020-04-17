import 'package:flutter/material.dart';
import 'package:zikanri/data.dart';
import 'package:provider/provider.dart';

class TMWidget extends StatefulWidget {
  @override
  _TMWidgetState createState() => _TMWidgetState();
}

class _TMWidgetState extends State<TMWidget> {
  @override
  //今日の日付
  //総ポイント thisMonthPoint
  //時間の平均価値　thisMonthValue
  //日平均ポイント　averagePoint
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 5,
          child: Container(
            padding: EdgeInsets.all(10),
            height: displaySize.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _widget(
                  '総ポイント',
                  userData.thisMonthPoint,
                ),
                _widget('平均価値', userData.thisMonthValue),
                _widget('日平均', userData.averagePoint),
              ],
            ),
          ),
        ));
  }

  Widget _widget(
    String title,
    var value,
  ) {
    return Container(
      width: displaySize.width / 3.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.radio_button_checked,
          ),
          Text(
            value.toString(),
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: FontSize.xxsmall,
            ),
          ),
        ],
      ),
    );
  }
}
