//packagea
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
//my files
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/ui/parts/bottom_sheet_bar.dart';

class ChangeNameSheet extends StatefulWidget {
  @override
  _ChangeNameSheetState createState() => _ChangeNameSheetState();
}

class _ChangeNameSheetState extends State<ChangeNameSheet> {
  TextEditingController nameController;
  String beforeName;
  @override
  void initState() {
    beforeName = Provider.of<UserDataNotifier>(context, listen: false).userName;
    nameController = TextEditingController(text: beforeName);
    super.initState();
  }

  bool nameCheck = true;

  void check(String text) {
    if (text.isEmpty) {
      setState(() {
        nameCheck = false;
      });
    } else {
      setState(() {
        nameCheck = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BottomSheetBar(),
          SizedBox(
            height: displaySize.width/17,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: displaySize.width/25),
            child: TextField(
              autofocus: true,
              controller: nameController,
              cursorColor: themeColor,
              decoration: InputDecoration(
                hintText: 'ユーザーの名前',
                labelStyle: TextStyle(
                  color: themeColor,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: themeColor,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: displaySize.width / 30,
                  horizontal: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
              ),
              onChanged: (text) {
                check(text);
              },
              style: TextStyle(
                fontSize: FontSize.midium,
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width/25,
          ),
          Container(
            margin: EdgeInsets.all(15),
            height: displaySize.width / 6.5,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              border: Border.all(
                color: nameCheck ? themeColor : themeColor.withOpacity(0.5),
                width: 3,
              ),
            ),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              color: Colors.transparent,
              child: Center(
                child: Text(
                  '変更する',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              onPressed: nameCheck
                  ? () {
                      if (beforeName != nameController.text) {
                        userData.editUserName(nameController.text);
                      }
                      Navigator.pop(context);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
