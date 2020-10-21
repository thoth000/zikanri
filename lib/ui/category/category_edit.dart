//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//my files
import 'package:zikanri/ui/category/icon.dart';
import 'package:zikanri/ui/category/name.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';

class CategoryEditPage extends StatelessWidget {
  const CategoryEditPage({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'カテゴリーの編集',
      ),
      body: Column(
        children: [
          _CategoryName(
            index: index,
          ),
          const Divider(
            height: 0,
          ),
          _CategoryIcon(
            index: index,
          ),
          const Divider(
            height: 0,
          ),
          _ViewSwitch(
            index: index,
          ),
          SizedBox(
            height: displaySize.width / 10,
          ),
          _DeleteData(
            index: index,
          ),
        ],
      ),
    );
  }
}

class _CategoryName extends StatelessWidget {
  const _CategoryName({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final String text = userData.categories[index][1];
    return ListTile(
      leading: Text(
        '名前　　 ',
        style: TextStyle(
          color: Colors.grey,
          fontSize: FontSize.xsmall,
        ),
      ),
      title: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          context: context,
          isScrollControlled: true,
          builder: (context) => EditNameSheet(
            name: text,
            index: index,
          ),
        );
      },
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  const _CategoryIcon({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    final int iconNum = userData.categories[index][0];
    return ListTile(
      leading: Text(
        'アイコン ',
        style: TextStyle(
          color: Colors.grey,
          fontSize: FontSize.xsmall,
        ),
      ),
      title: Row(
        children: [
          Icon(
            IconData(
              iconNum,
              fontFamily: 'MaterialIcons',
            ),
          ),
        ],
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditIconPage.wrapped(
              index: index,
              selectedIcon: iconNum,
            ),
          ),
        );
      },
    );
  }
}

class _ViewSwitch extends StatelessWidget {
  const _ViewSwitch({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final bool boolean =
        Provider.of<UserDataNotifier>(context).categoryView[index];
    return ListTile(
      leading: Text(
        '表示　　 ',
        style: TextStyle(
          color: Colors.grey,
          fontSize: FontSize.xsmall,
        ),
      ),
      title: Text(boolean ? '表示中' : '非表示'),
      trailing: Switch(
        value: boolean,
        activeColor:
            (theme.isDark) ? theme.themeColors[0] : theme.themeColors[1],
        onChanged: (b) {},
      ),
      onTap: () {
        Provider.of<UserDataNotifier>(context, listen: false)
            .switchCategoryView(index);
      },
    );
  }
}

class _DeleteData extends StatelessWidget {
  const _DeleteData({this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                'リセットする',
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
          showDialog(
            context: context,
            builder: (context) => _ResetCategoryDialog(index: index),
          );
        },
      ),
    );
  }
}

class _ResetCategoryDialog extends StatelessWidget {
  _ResetCategoryDialog({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text('リセット'),
      content: const Text('このカテゴリーの記録が全てリセットされます。\nそれでもよろしいですか？'),
      actions: <Widget>[
        FlatButton(
          child: const Text('いいえ'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: const Text('はい'),
          onPressed: () {
            userData.resetCategory(index);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
