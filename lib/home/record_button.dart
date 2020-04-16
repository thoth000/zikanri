import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../record/record.dart';

class RButton extends StatelessWidget {
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    final userData = Provider.of<UserDataNotifier>(context);
    return RaisedButton(
      elevation: 10,
      shape: CircleBorder(),
      child: Container(
        height: displaySize.width / 5,
        width: displaySize.width / 5,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: theme.themeColors),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.access_time,
          size: displaySize.width / 7,
          color: Colors.white,
        ),
      ),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => RecordPage())),
      onLongPress: () => showDialog(
          context: context,
          builder: (context) => shortCutDialog(context, userData)),
    );
  }

  Widget shortCutDialog(context, userData) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        height: displaySize.width / 1.5,
        width: displaySize.width / 1.5,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SimpleDialogOption(
                child: Text('ショートカットを編集'),
                onPressed: () => Navigator.pop(context),
              ),
              Divider(),
              for (var itemList in userData.shortCuts)
                SimpleDialogOption(
                  child: Text(
                    itemList[1],
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  onPressed: () {
                    userData.recordDone(itemList);
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
