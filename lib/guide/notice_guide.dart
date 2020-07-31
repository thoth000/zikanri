import 'package:flutter/material.dart';
import 'package:zikanri/data.dart';
import 'package:zikanri/guide/quick_guide.dart';

class NoticeGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: displaySize.width / 20,
        left: displaySize.width / 20,
        right: displaySize.width / 20,
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: displaySize.width / 50,
            ),
            Text(
              'ようこそ！',
              style: TextStyle(
                fontSize: FontSize.small,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: displaySize.width / 50,
            ),
            const Divider(
              height: 1,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            Text(
              "Zikanriの使い方について",
              style: TextStyle(
                fontSize: FontSize.xsmall,
              ),
            ),
            Text(
              "クイックガイドがあります。",
              style: TextStyle(
                fontSize: FontSize.xsmall,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(displaySize.width / 50),
              child: FlatButton(
                child: Text(
                  "クイックガイドを読む",
                  style: TextStyle(
                    fontSize: FontSize.xsmall,
                    color: Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuickGuide(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
