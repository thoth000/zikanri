import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/data.dart';

class GeneralAppBar extends StatelessWidget with PreferredSizeWidget {
  final String pageTitle;
  GeneralAppBar({this.pageTitle});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ThemeNotifier>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        pageTitle,
        style: TextStyle(
          color: controller.isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}