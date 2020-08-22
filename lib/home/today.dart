//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/data.dart';


class TodayWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: displaySize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
                color:
                    theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
                width: 2),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          '価値時間',
                          style: TextStyle(
                              fontSize: FontSize.midium,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Text(
                      userData.todayGood.toString() + '分 ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: FontSize.xxlarge,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                ),
                Text(
                  '記録',
                  style: TextStyle(
                      fontSize: FontSize.midium, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = userData.todayDoneList.length - 1; i >= 0; i--)
                  TodayDone(
                    index: i,
                  ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(
                      (userData.todayDoneList.length == 0)
                          ? displaySize.width / 10
                          : 0,
                    ),
                    child: Text(
                      (userData.todayDoneList.length == 0)
                          ? '今日の活動を記録しよう！'
                          : '',
                      style: TextStyle(
                        fontSize: FontSize.xsmall,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TodayDone extends StatelessWidget {
  const TodayDone({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    var itemList = userData.todayDoneList[index];
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              IconData(
                userData.categories[itemList[0]][0],
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 10,
              //カラーは価値時間ならテーマカラーを、価値なしではグレーを用いる
              color: (itemList[3])
                  ? (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1]
                  : Colors.grey,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  itemList[1],
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  itemList[2].toString() + '分',
                  style: TextStyle(
                    fontSize: FontSize.xxsmall,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
            ),
            iconSize: displaySize.width / 12,
            color: theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
            onPressed: () => showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) => AddSheet(
                index: index,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.remove_circle_outline,
            ),
            iconSize: displaySize.width / 12,
            color: theme.isDark ? theme.themeColors[0] : theme.themeColors[1],
            onPressed: () => showDialog(
              context: context,
              child: _deleteAlert(context, itemList, index, userData),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deleteAlert(context, itemList, index, userData) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        '削除',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
      content: const Text('この記録を削除しますか？'),
      actions: <Widget>[
        FlatButton(
          child: const Text('いいえ'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: const Text('はい'),
          onPressed: () {
            userData.deleteDone(itemList, index);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class AddSheet extends StatefulWidget {
  const AddSheet({this.index});
  final int index;

  @override
  _AddSheetState createState() => _AddSheetState();
}

class _AddSheetState extends State<AddSheet> {
  TextEditingController timeController;
  void initState() {
    super.initState();
    setState(() {
      timeController = TextEditingController();
    });
  }

  int time = 0;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    final theme = Provider.of<ThemeNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 1.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 50,
            margin: const EdgeInsets.all(12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
          ),
          Text(
            '時間の追加',
            style: TextStyle(
                fontSize: FontSize.large, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
          Row(
            children: [
              Text(
                '　時間（分）',
                style: TextStyle(
                  fontSize: FontSize.small,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: timeController,
              style: TextStyle(
                fontSize: FontSize.small,
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.go,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                fillColor: Colors.grey,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 1,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              onChanged: (text) {
                setState(() {
                  if (text.isEmpty) {
                    time = 0;
                  } else {
                    time = int.parse(text);
                  }
                });
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(
                  color:
                      (time > 0 && time < 501) ? color : color.withOpacity(0.5),
                  width: 3,
                ),
              ),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500),
                ),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        '保存する',
                        style: TextStyle(
                          color: (time > 0 && time < 501) ? null : Colors.grey,
                          fontSize: FontSize.small,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: (time > 0 && time < 501)
                    ? () async {
                        userData.addTime(widget.index, time);
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
