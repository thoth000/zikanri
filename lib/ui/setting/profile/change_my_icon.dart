//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/controller/select_icon_controller.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';

class ChangeMyIconPage extends StatelessWidget {
  ChangeMyIconPage._();
  static Widget wrapped({@required int beforeIcon}) {
    return ChangeNotifierProvider(
      create: (_) => SelectIconController(
        beforeIcon: beforeIcon,
      ),
      child: ChangeMyIconPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBar(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Wrap(
          children: List.generate(
            newIconList.length,
            (index) {
              return _MyIconButton(
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final selectController = Provider.of<SelectIconController>(context);
    final beforeIcon = selectController.beforeIcon;
    final selectedIcon = selectController.selectedIcon;
    final ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      title: Text(
        'アイコン',
        style: TextStyle(
          color: themeNotifier.isDark ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.check),
          onPressed: () async {
            final isNotSameIcon = beforeIcon != selectedIcon;
            if (isNotSameIcon) {
              await Provider.of<UserDataNotifier>(context, listen: false)
                  .editMyIcon(selectedIcon);
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyIconButton extends StatelessWidget {
  _MyIconButton({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final selectController = Provider.of<SelectIconController>(context);
    final int selectedIcon = selectController.selectedIcon;
    final ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    final Color themeColor = (themeNotifier.isDark)
        ? themeNotifier.themeColors[0]
        : themeNotifier.themeColors[1];
    return Container(
      height: displaySize.width / 5 - 8,
      width: displaySize.width / 5 - 8,
      margin: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color:
              (selectedIcon == newIconList[index]) ? themeColor : Colors.grey,
          width: 3,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              IconData(
                newIconList[index],
                fontFamily: 'MaterialIcons',
              ),
              color: (themeNotifier.isDark) ? Colors.white : Colors.black,
              size: displaySize.width / 12,
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
                selectController.selectIcon(newIconList[index]);
              },
              child: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
