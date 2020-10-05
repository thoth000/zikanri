import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';

class ChangeMyIconPage extends StatefulWidget {
  @override
  _ChangeMyIconPageState createState() => _ChangeMyIconPageState();
}

class _ChangeMyIconPageState extends State<ChangeMyIconPage> {
  int iconNumber = 0;
  int beforeIcon = 0;
  void initState() {
    beforeIcon = Provider.of<UserDataNotifier>(context, listen: false).myIcon;
    iconNumber = beforeIcon;
    super.initState();
  }

  void changeIcon(int selectedIconNumber) {
    setState(() {
      iconNumber = selectedIconNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    final Color themeColor = (themeNotifier.isDark)
        ? themeNotifier.themeColors[0]
        : themeNotifier.themeColors[1];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'アイコン',
          style: TextStyle(
            color: themeNotifier.isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              if (beforeIcon != iconNumber) {
                await Provider.of<UserDataNotifier>(context, listen: false)
                    .editMyIcon(iconNumber);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: [
            for (int i = 0; i < newIconList.length; i++)
              Container(
                height: displaySize.width / 5 - 8,
                width: displaySize.width / 5 - 8,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: (iconNumber == newIconList[i])
                        ? themeColor
                        : Colors.grey,
                    width: 3,
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        IconData(
                          newIconList[i],
                          fontFamily: 'MaterialIcons',
                        ),
                        color: (themeNotifier.isDark)
                            ? Colors.white
                            : Colors.black,
                        size: displaySize.width / 12,
                      ),
                    ),
                    SizedBox(
                      height: displaySize.width / 5 - 8,
                      width: displaySize.width / 5 - 8,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          changeIcon(newIconList[i]);
                        },
                        child: const SizedBox(),
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
