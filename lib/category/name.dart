import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/data.dart';

class EditNameSheet extends StatefulWidget {
  EditNameSheet({this.name, this.index});
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
            margin: EdgeInsets.all(12.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: displaySize.width / 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: controller,
              maxLength: 20,
              style: TextStyle(
                fontSize: FontSize.small,
              ),
              decoration: InputDecoration(
                fillColor: Colors.grey,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color,
                    width: 3,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "保存する",
                      style: TextStyle(
                        color: Colors.white,
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
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
