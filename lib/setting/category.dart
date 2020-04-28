import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import 'icon_select.dart';

class EditCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'カテゴリーの編集',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: Container(
        width: displaySize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'カテゴリーの追加',
              style: TextStyle(
                  fontSize: FontSize.small, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: displaySize.width / 1.8,
                width: displaySize.width / 1.2,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            ' アイコン',
                            style: TextStyle(
                              fontSize: FontSize.small,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: SizedBox(
                              height: displaySize.width / 7,
                              width: displaySize.width / 7,
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Icon(
                                      IconData(record.icon,
                                          fontFamily: "MaterialIcons"),
                                      size: displaySize.width / 8,
                                    ),
                                  ),
                                  SizedBox(
                                    height: displaySize.width / 7,
                                    width: displaySize.width / 7,
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SelectIconPage(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            ' タイトル',
                            style: TextStyle(
                              fontSize: FontSize.small,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            width: displaySize.width / 2,
                            child: TextField(
                              cursorColor: (theme.isDark)
                                  ? theme.themeColors[0]
                                  : theme.themeColors[1],
                              decoration: InputDecoration(
                                hintText: 'タイトルを入力',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: (theme.isDark)
                                          ? theme.themeColors[0]
                                          : theme.themeColors[1],
                                      width: 2),
                                ),
                              ),
                              textInputAction: TextInputAction.go,
                              onChanged: (s) => record.setCategoryTitle(s),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            (record.categoryError && record.categoryTitle == "")
                                ? 'タイトルを決めてください'
                                : '',
                            style: TextStyle(color: Colors.red),
                          ),
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Container(
                              height: displaySize.width / 10,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Text(
                                  '追加',
                                  style: TextStyle(
                                      fontSize: FontSize.small,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () async {
                                  if (record.categoryTitle == "") {
                                    Vib.error();
                                    record.cErrorCheck();
                                  } else {
                                    Vib.decide();
                                    await userData.addCategory([
                                      userData.categorykey.toString(),
                                      record.icon,
                                      record.categoryTitle,
                                      [0, 0, 0],
                                    ]);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'カテゴリー一覧',
              style: TextStyle(
                  fontSize: FontSize.small, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ReorderableListView(
                children: <Widget>[
                  for (int i = 1; i < userData.categories.length; i++)
                    Card(
                      key: Key(userData.categories[i][0]),
                      child: ListTile(
                        leading: Icon(
                          IconData(
                            userData.categories[i][1],
                            fontFamily: 'MaterialIcons',
                          ),
                          color: (theme.isDark)
                              ? theme.themeColors[0]
                              : theme.themeColors[1],
                          size: displaySize.width / 12,
                        ),
                        title: Text(
                          userData.categories[i][2],
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                          ),
                          iconSize: displaySize.width / 12,
                          color: theme.isDark
                              ? theme.themeColors[0]
                              : theme.themeColors[1],
                          onPressed: () => userData.deleteCategory(i),
                        ),
                      ),
                    ),
                ],
                onReorder: (oldIndex, newIndex) =>
                    userData.sortCategory(oldIndex + 1, newIndex + 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}