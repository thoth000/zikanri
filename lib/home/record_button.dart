import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class RButton extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return Container(
      height: displaySize.width / 5,
      width: displaySize.width / 5,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: theme.themeColors),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              spreadRadius: 1.0,
              color: Colors.black38,
              blurRadius: 7,
              offset: Offset(5, 5),
            ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(
              Icons.access_time,
              color: Colors.white,
              size: displaySize.width/7,
            ),
          ),
          Center(
            child: FlatButton(
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              child: Container(),
              onPressed: () => showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                context: context,
                isScrollControlled: true,
                builder: (context) => bottomsheet(context, theme, userData),
              ),
              onLongPress: () => showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                context: context,
                isScrollControlled: true,
                builder: (context) => shortCutSheet(context, userData),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomsheet(BuildContext context, theme, userData) {
    final _decorationStyle = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey),
    );
    final _headlineStyle = TextStyle(
      fontSize: FontSize.small,
      fontWeight: FontWeight.w700,
    );
    final record = Provider.of<RecordNotifier>(context);

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: FractionallySizedBox(
        heightFactor: 0.7,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 5,
                width: 50,
                margin: EdgeInsets.all(12.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey,
                ),
              ),
              Text(
                '記録の追加',
                style: TextStyle(
                    fontSize: FontSize.large, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 1,
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'タイトル',
                          style: _headlineStyle,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: _decorationStyle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration.collapsed(
                                hintText: "タイトルを入力",
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(20)
                              ],
                              textInputAction: TextInputAction.go,
                              onChanged: (s) => record.changeTitle(s),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '時間（分）',
                              style: _headlineStyle,
                            ),
                            Container(
                              width: displaySize.width / 2.5,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 2,
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                  ],
                                  textInputAction: TextInputAction.go,
                                  decoration:
                                      InputDecoration.collapsed(hintText: "60"),
                                  onChanged: (s) => record.changeTime(s),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '価値',
                              style: _headlineStyle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: displaySize.width / 2.5,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    for (int i = 0; i < 6; i++)
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                            height: displaySize.width / 6.5,
                                            width: displaySize.width / 6.5,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: (record.rating == i)
                                                      ? (theme.isDark)
                                                          ? theme.themeColors[0]
                                                          : theme.themeColors[1]
                                                      : Colors.grey,
                                                  width: (record.rating == i)
                                                      ? 3
                                                      : 1,
                                                ),
                                              ),
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                onPressed: () =>
                                                    record.changeValue(i),
                                                child: Text(
                                                  i.toString(),
                                                  style: TextStyle(
                                                    fontSize: FontSize.small,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          )
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: displaySize.width / 6.5,
                          width: displaySize.width / 1.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(500),
                              border: Border.all(
                                color: (theme.isDark)
                                    ? theme.themeColors[0]
                                    : theme.themeColors[1],
                                width: 3,
                              )),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(500),
                            ),
                            onPressed: () {
                              if (record.title == "" || record.timecheck) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text('ワーニング')));
                              } else {
                                userData.recordDone([
                                  record.category,
                                  record.title,
                                  record.time.toString(),
                                  record.rating.toString(),
                                  (record.time * record.rating).toString(),
                                ]);
                                record.initialize();
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              '記録する',
                              style: TextStyle(
                                  fontSize: FontSize.midium,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'カテゴリー',
                          style: _headlineStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          children: <Widget>[
                            for (var itemList in iconList)
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 5, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: displaySize.width / 6.5,
                                      width: displaySize.width / 6.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color:
                                              (record.category == itemList[0])
                                                  ? (theme.isDark)
                                                      ? theme.themeColors[0]
                                                      : theme.themeColors[1]
                                                  : Colors.grey,
                                          width:
                                              (record.category == itemList[0])
                                                  ? 3
                                                  : 1,
                                        ),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          IconData(
                                            int.parse(itemList[0]),
                                            fontFamily: "MaterialIcons",
                                          ),
                                          color: (theme.isDark)
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        onPressed: () => record
                                            .changeCategory(itemList[0]),
                                      ),
                                    ),
                                    Text(
                                      itemList[1],
                                      style: TextStyle(
                                        fontSize: FontSize.xxsmall,
                                      ),
                                    ),
                                  ],
                                ),
                              ), //TODO:並び替え対応
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget shortCutSheet(context, userData) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 5,
              width: 50,
              margin: EdgeInsets.all(12.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey,
              ),
            ),
            Text(
              "記録の追加",
              style: TextStyle(
                fontSize: FontSize.large,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "ショートカットモード",
              style: TextStyle(
                fontSize: FontSize.small,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: displaySize.width / 6.5,
                width: displaySize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () => tmp = 1, //TODO:画面の作成
                  child: Center(
                    child: Text(
                      'ショートカットの編集をする',
                      style: TextStyle(fontSize: FontSize.small),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 1,
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  for (var itemList in userData.shortCuts)
                    Container(
                      height: displaySize.width / 6.5,
                      width: displaySize.width,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          userData.recordDone(itemList);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              IconData(
                                int.parse(itemList[0]),
                                fontFamily: "MaterialIcons",
                              ),
                              size: displaySize.width / 10,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              itemList[1],
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              style: TextStyle(
                                fontSize: FontSize.xsmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
