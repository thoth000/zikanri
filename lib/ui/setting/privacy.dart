//packages
import 'package:flutter/material.dart';
import 'package:zikanri/config.dart';
//my files
import 'package:zikanri/ui/parts/general_app_bar.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontWeight: FontWeight.w700);

    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: 'プライバシーポリシー',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaySize.width / 35),
        child: ListView(
          children: [
            Text(
              'Zikanri プライバシーポリシー',
              style: titleStyle,
            ),
            space(),
            space(),
            Text(
              '利用者情報の取得',
              style: titleStyle,
            ),
            space(),
            Text(
                '当アプリでは利用状況解析のために、匿名で個人を特定できない範囲でGoogle Firebase Analyticsを使用しています。'),
            space(),
            Text(
              '収集情報の利用目的',
              style: titleStyle,
            ),
            space(),
            Text('収集した情報は、当アプリの品質・機能向上のために利用いたします。'),
            space(),
            Text(
              '免責事項',
              style: titleStyle,
            ),
            space(),
            Text(
                '利用上の不具合・不都合に対して可能な限りサポートを行っておりますが、利用者が本アプリを利用して生じた損害に関して、開発元は責任を負わないものとします。'),
            space(),
            Text(
              '著作権・知的財産権等',
              style: titleStyle,
            ),
            space(),
            Text('著作権その他一切の権利は、当方又は権利を有する第三者に帰属します。'),
            space(),
            Text(
              'お問い合せ',
              style: titleStyle,
            ),
            space(),
            Text('お問い合わせは下記メールまでご連絡ください。'),
            Text('Mail : dev.thoth000@gmail.com'),
          ],
        ),
      ),
    );
  }

  Widget space() {
    return SizedBox(
      height: displaySize.width / 35,
    );
  }
}
