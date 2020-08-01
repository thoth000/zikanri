import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/data.dart';

class FeatureGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ThemeNotifier>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "機能ガイド",
        style: TextStyle(
          color: controller.isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
