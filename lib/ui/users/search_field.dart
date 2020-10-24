//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: displaySize.width / 50,
        ),
        _SearchTextField(),
        _SearchButton(),
        SizedBox(
          width: displaySize.width / 50,
        ),
      ],
    );
  }
}

class _SearchTextField extends StatefulWidget {
  @override
  __SearchTextFieldState createState() => __SearchTextFieldState();
}

class __SearchTextFieldState extends State<_SearchTextField> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    setState(() {
      textEditingController = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final usersController = Provider.of<UsersController>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: (text) {
                usersController.changeText(text);
              },
              cursorColor: themeColor,
              decoration: InputDecoration(
                hintText: '@でID検索, 名前検索',
                contentPadding: EdgeInsets.symmetric(
                  vertical: displaySize.width / 30,
                  horizontal: 10,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: themeColor,
                    width: 2,
                  ),
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
          (usersController.searchWord.isEmpty)
              ? SizedBox(
                  width: displaySize.width / 50,
                )
              : Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: displaySize.width / 50),
                  height: displaySize.width / 9,
                  width: displaySize.width / 9,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: themeColor,
                      width: 2,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.clear,
                          size: displaySize.width / 11,
                          color: themeColor,
                        ),
                      ),
                      SizedBox(
                        height: displaySize.width / 9,
                        width: displaySize.width / 9,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(500),
                          ),
                          onPressed: () {
                            textEditingController.clear();
                            usersController.changeText('');
                            FocusScope.of(context).unfocus();
                            usersController.resetSearch();
                          },
                          child: const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final usersController = Provider.of<UsersController>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      height: displaySize.width / 9,
      width: displaySize.width / 9,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: themeColor,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              Icons.search,
              size: displaySize.width / 11,
              color: themeColor,
            ),
          ),
          SizedBox(
            height: displaySize.width / 9,
            width: displaySize.width / 9,
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(500),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                usersController.searchUsers(usersController.inputText);
              },
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
