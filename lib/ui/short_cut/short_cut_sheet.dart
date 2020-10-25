//packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/record/notification.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/short_cut/short_cut_edit.dart';

class ShortCutSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              '記録の追加',
              style: TextStyle(
                fontSize: FontSize.large,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'ショートカットモード',
              style: TextStyle(
                fontSize: FontSize.small,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: displaySize.width/35,
            ),
            _MoveShortCutEditButton(),
            SizedBox(
              height: displaySize.width/70,
            ),
            Divider(
              height: displaySize.width/35,
            ),
            _ShortCutList(),
          ],
        ),
      ),
    );
  }
}

class _MoveShortCutEditButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShortCutsEditPage(),
            ),
          ),
          child: Center(
            child: Text(
              'ショートカットの編集をする',
              style: TextStyle(fontSize: FontSize.small),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShortCutList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Expanded(
      child: ListView(
        children: List.generate(
          userData.shortCuts.length,
          (index) {
            final List itemList = userData.shortCuts[index];
            return _ShortCut(itemList: itemList);
          },
        ),
      ),
    );
  }
}

class _ShortCut extends StatelessWidget {
  _ShortCut({@required this.itemList});
  final List itemList;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    final theme = Provider.of<ThemeNotifier>(context, listen: false);
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: displaySize.width/70),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: displaySize.width / 6.5,
          width: displaySize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () async {
              if (itemList[5]) {
                userData.recordDone(itemList);
              } else {
                notification(itemList[1], userData.activities.length);
                userData.addActivity(DateTime.now(), itemList[1], itemList[0]);
              }
              Navigator.pop(context);
            },
            child: SizedBox(
              width: displaySize.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          IconData(
                            userData.categories[itemList[0]][0],
                            fontFamily: 'MaterialIcons',
                          ),
                          color: (itemList[3]) ? color : Colors.grey,
                          size: displaySize.width / 10,
                        ),
                        SizedBox(
                          width: displaySize.width/35,
                        ),
                        Flexible(
                          child: Text(
                            itemList[1],
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: FontSize.xsmall,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: displaySize.width/35,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      (itemList[5]) ? '記録' : '開始',
                      style: TextStyle(
                        fontSize: FontSize.small,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
