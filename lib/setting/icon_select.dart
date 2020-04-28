import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class SelectIconPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final record = Provider.of<RecordNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'アイコンの選択',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: <Widget>[
            for (int i = 0; i < iconList.length; i++)
              SizedBox(
                height: displaySize.width / 4,
                width: displaySize.width / 4,
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Icon(
                        IconData(int.parse(iconList[i][0]),
                            fontFamily: 'MaterialIcons'),
                        size: displaySize.width / 8,
                      ),
                    ),
                    Center(
                      child: Container(
                        height: displaySize.width / 6,
                        width: displaySize.width / 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: (record.icon == int.parse(iconList[i][0]))
                                ? (theme.isDark)
                                    ? theme.themeColors[0]
                                    : theme.themeColors[1]
                                : Colors.grey,
                            width: (record.icon == int.parse(iconList[i][0]))
                                ? 3
                                : 1,
                          ),
                        ),
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(),
                          onPressed: () {
                            record.setIcon(i);
                          },
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
