import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/users_controller.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final usersController = Provider.of<UsersController>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: displaySize.width / 50,
        ),
        Expanded(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: '@でID検索, 名前検索',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
            ),
          ),
        ),
        //キャンセルボタン
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
                    width: 3,
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
                          FocusScope.of(context).unfocus();
                          usersController.resetSearch();
                        },
                        child: const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ),
        //検索ボタン
        Container(
          height: displaySize.width / 9,
          width: displaySize.width / 9,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: themeColor,
              width: 3,
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
                    usersController.searchUsers(textEditingController.text);
                  },
                  child: const SizedBox(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: displaySize.width / 50,
        ),
      ],
    );
  }
}

class CancellButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final usersController = Provider.of<UsersController>(context);
    final Color themeColor =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    if (usersController.searchWord.isEmpty) {
      return SizedBox();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: displaySize.width / 50),
      height: displaySize.width / 9,
      width: displaySize.width / 9,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: themeColor,
          width: 3,
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
                usersController.resetSearch();
              },
              child: SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
