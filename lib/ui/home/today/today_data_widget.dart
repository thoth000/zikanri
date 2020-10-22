//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class TodayDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '価値時間',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          userData.todayGood.toString() + '分 ',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: FontSize.xxlarge,
          ),
        ),
      ],
    );
  }
}
