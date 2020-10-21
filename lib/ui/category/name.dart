//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class EditNameSheet extends StatefulWidget {
  const EditNameSheet({this.name, this.index});
  final String name;
  final int index;

  @override
  _EditNameSheetState createState() => _EditNameSheetState();
}

class _EditNameSheetState extends State<EditNameSheet> {
  TextEditingController controller;
  void initState() {
    controller = TextEditingController(text: widget.name);
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    final theme = Provider.of<ThemeNotifier>(context);
    Color themeColor = (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom * 1.1),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 70,
            margin: const EdgeInsets.all(12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: displaySize.width / 50,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              maxLength: 20,
              style: TextStyle(
                fontSize: FontSize.small,
              ),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'カテゴリーの名前',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: themeColor,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: displaySize.width/30,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: displaySize.width/6.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500),
                border: Border.all(
                  color: themeColor,
                  width: 3,
                ),
              ),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(displaySize.width / 100),
                      child: Text(
                        '保存する',
                        style: TextStyle(
                          fontSize: FontSize.small,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  userData.editCategoryTitle(widget.index, controller.text);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          SizedBox(
            height: displaySize.width/20,
          ),
        ],
      ),
    );
  }
}
