//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zikanri/controller/icon_controller.dart';
//my files
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';

class EditIconPage extends StatelessWidget {
  const EditIconPage._();
  static Widget wrapped({int index, int selectedIcon}) {
    return ChangeNotifierProvider(
      create: (_) => IconController(
        index: index,
        icon: selectedIcon,
      ),
      child: EditIconPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          children: List.generate(
            newIconList.length,
            (index) => _CategoryIconButton(index: index),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    final iconController = Provider.of<IconController>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    final theme = Provider.of<ThemeNotifier>(context);
    final int index = iconController.index;
    final int selectedIcon = iconController.selectedIcon;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
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
            userData.editCategoryIcon(index, selectedIcon);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _CategoryIconButton extends StatelessWidget {
  _CategoryIconButton({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final iconController = Provider.of<IconController>(context);
    final theme = Provider.of<ThemeNotifier>(context, listen: false);
    final selectedIcon = iconController.selectedIcon;
    final Color color =
        (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      height: displaySize.width / 5 - 8,
      width: displaySize.width / 5 - 8,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (selectedIcon == newIconList[index]) ? color : Colors.grey,
          width: 3,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              IconData(newIconList[index], fontFamily: 'MaterialIcons'),
              size: displaySize.width / 12,
              color: theme.isDark ? Colors.white : Colors.black,
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
                iconController.selectIcon(newIconList[index]);
              },
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
