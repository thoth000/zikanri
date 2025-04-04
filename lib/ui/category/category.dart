//packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//my files
import 'package:zikanri/ui/category/category_edit.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(pageTitle: 'カテゴリーの編集'),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: displaySize.width / 35),
            child: Column(
              children: List<Widget>.generate(
                7,
                (index) => _CategoryCard(index: index + 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displaySize.width / 3,
      width: displaySize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: _CategoryDataWidget(index: index),
          ),
          _EditButton(index: index),
        ],
      ),
    );
  }
}

class _CategoryDataWidget extends StatelessWidget {
  _CategoryDataWidget({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataNotifier>(context);
    return Container(
      height: displaySize.width / 3.2,
      width: displaySize.width / 1.7,
      padding: EdgeInsets.all(displaySize.width / 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: displaySize.width / 8,
            width: displaySize.width / 8,
            child: Icon(
              IconData(
                userData.categories[index][0],
                fontFamily: 'MaterialIcons',
              ),
              size: displaySize.width / 8,
            ),
          ),
          SizedBox(
            width: displaySize.width / 35,
          ),
          Flexible(
            child: Text(
              userData.categories[index][1],
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: FontSize.midium,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  _EditButton({@required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context, listen: false);
    final color = theme.isDark ? theme.themeColors[0] : theme.themeColors[1];
    return Container(
      height: displaySize.width / 4,
      width: displaySize.width / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: RaisedButton(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '編集',
          style: TextStyle(
            fontSize: FontSize.small,
            fontWeight: FontWeight.w700,
          ),
        ),
        color: theme.isDark ? const Color(0XFF424242) : Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryEditPage(
                index: index,
              ),
            ),
          );
        },
      ),
    );
  }
}
