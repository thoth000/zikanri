//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class ThisMonthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Padding(
      padding: EdgeInsets.all(displaySize.width/35),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(displaySize.width/35),
          height: displaySize.width / 2.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _DataWidget(
                dataTitle: '記録時間',
                dataValue: userData.thisMonthTime.toString() + '分',
              ),
              _DataWidget(
                dataTitle: '価値時間',
                dataValue: userData.thisMonthGood.toString() + '分',
              ),
              _DataWidget(
                dataTitle: '価値の割合',
                dataValue: userData.thisMonthPer.toString() + '%',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DataWidget extends StatelessWidget {
  _DataWidget({@required this.dataTitle, @required this.dataValue});
  final String dataTitle;
  final String dataValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displaySize.width / 3.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Icon(
            Icons.radio_button_checked,
          ),
          Text(
            dataValue,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: FontSize.large,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            dataTitle,
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
