//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class EditIconPage extends StatefulWidget {
  const EditIconPage({this.index, this.iconNum});
  final int index;
  final int iconNum;
  @override
  _EditIconPageState createState() => _EditIconPageState();
}

class _EditIconPageState extends State<EditIconPage> {
  int selectedIcon;
  void initState() {
    selectedIcon = widget.iconNum;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    Color color = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    void selectIcon(int iconNum) {
      setState(() {
        selectedIcon = iconNum;
      });
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'アイコン',
          style: TextStyle(
            color: theme.isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              userData.editCategoryIcon(widget.index, selectedIcon);
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
                    color: (selectedIcon == newIconList[i]) ? color : Colors.grey,
                    width: 3,
                  ),
                ),
                child: FlatButton(
                  onPressed: () {
                    selectIcon(newIconList[i]);
                  },
                  child: Center(
                    child: Icon(
                      IconData(newIconList[i], fontFamily: 'MaterialIcons'),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
