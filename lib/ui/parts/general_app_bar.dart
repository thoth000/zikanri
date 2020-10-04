//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/controller/theme_notifier.dart';

class GeneralAppBar extends StatelessWidget with PreferredSizeWidget {
  GeneralAppBar({@required this.pageTitle});
  final String pageTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ThemeNotifier>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        pageTitle,
        style: TextStyle(
          color: controller.isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
