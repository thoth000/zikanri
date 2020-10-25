//packages
import 'package:flutter/material.dart';

//my files
import 'package:zikanri/config.dart';
import 'package:zikanri/ui/parts/general_app_bar.dart';

class FeatureGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBar(
        pageTitle: '機能ガイド',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: displaySize.width / 20),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: displaySize.width / 20,
            ),
            _AnalyzeData(),
            Divider(
              height: displaySize.width / 6,
            ),
            _Share(),
            Divider(
              height: displaySize.width / 6,
            ),
            _Register(),
            Divider(
              height: displaySize.width / 6,
            ),
            _Theme(),
            Divider(
              height: displaySize.width / 6,
            ),
            _ShortCut(),
            Divider(
              height: displaySize.width / 10,
            ),
            SizedBox(
              height: displaySize.width / 20,
            ),
            _ClosePageButton(),
            SizedBox(
              height: displaySize.width / 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyzeData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          '記録データの集計',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
          '時間価値・記録した日付・カテゴリーで\n記録データを分析します。\n振り返ることで気づきがあるかもしれません。',
        ),
      ],
    );
  }

  Widget image() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.assessment,
          color: Colors.blue,
          size: displaySize.width / 8,
        ),
        SizedBox(
          width: displaySize.width / 20,
        ),
        Icon(
          Icons.data_usage,
          color: Colors.blue,
          size: displaySize.width / 8,
        ),
      ],
    );
  }
}

class _Share extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          'SNSシェア',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
          '集計した記録データをSNSを使って共有できます。\n上のような共有ボタンを押すとシェア画面が開きます。',
        ),
      ],
    );
  }

  Widget image() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.share,
          color: Colors.blue,
          size: displaySize.width / 8,
        ),
      ],
    );
  }
}

class _Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          'ユーザー登録',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
          '登録で他のユーザーを見つけて価値時間で競えます。\nまた、オンライン上にバックアップを取れます。\nこれで新しい携帯にデータを引き継げます。',
        ),
      ],
    );
  }

  Widget image() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.people,
          color: Colors.blue,
          size: displaySize.width / 8,
        ),
        SizedBox(
          width: displaySize.width / 20,
        ),
        Icon(
          Icons.emoji_events,
          color: Colors.blue,
          size: displaySize.width / 8,
        ),
      ],
    );
  }
}

class _Theme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          'テーマ・実績',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
          'アプリのテーマを最大12種類から選べます。\n実績はアプリを使い込むことで解除されて\n毎回新しいテーマを獲得できます。\nお気に入りのテーマを選びましょう。',
        ),
      ],
    );
  }

  Widget image() {
    return Row(
      children: <Widget>[
        item(0),
        SizedBox(
          width: displaySize.width / 20,
        ),
        item(1),
        SizedBox(
          width: displaySize.width / 20,
        ),
        item(2),
        SizedBox(
          width: displaySize.width / 20,
        ),
        Icon(
          Icons.more_horiz,
          size: displaySize.width / 8,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget item(int index) {
    return Container(
      height: displaySize.width / 7,
      width: displaySize.width / 7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        gradient: LinearGradient(
          colors: baseColors[index],
        ),
      ),
    );
  }
}

class _ShortCut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        image(),
        SizedBox(
          height: displaySize.width / 20,
        ),
        Text(
          '記録のショートカット',
          style: TextStyle(
            fontSize: FontSize.midium,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: displaySize.width / 50,
        ),
        const Text(
            '記録が面倒ではありませんか？\nジカンリにはショートカット機能がついています。\n「記録する」「開始する」ボタンを長押しすると\n記録だけでなくショートカットにも保存されます。'),
        const Text(
          '保存したショートカットを使うには\n記録ボタンを長押しするだけです。',
        ),
        Center(
          child: _RecordButton(),
        ),
      ],
    );
  }

  Widget image() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          Icons.access_time,
          color: Colors.grey,
          size: displaySize.width / 12,
        ),
        title: Text(
          'ショートカット時短',
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        trailing: Container(
          padding: EdgeInsets.all(displaySize.width/70),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[300],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '記録',
            style: TextStyle(
              fontSize: FontSize.small,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: displaySize.width / 10,
        vertical: 15,
      ),
      child: Container(
        height: displaySize.width / 7,
        width: displaySize.width / 1.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          border: Border.all(
            color: Colors.blue,
            width: 3,
          ),
        ),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(500),
          ),
          onPressed: () {
            Vib.decide();
            Scaffold.of(context).showSnackBar(
              snackBar('長押しができていません。'),
            );
          },
          onLongPress: () {
            Vib.shortCut();
            Scaffold.of(context).showSnackBar(
              snackBar('ショートカットに保存しました。'),
            );
          },
          child: Text(
            '記録する',
            style: TextStyle(
              fontSize: FontSize.small,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget snackBar(String title) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(title),
      duration: const Duration(milliseconds: 1500),
    );
  }
}

class _ClosePageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Padding(
        padding: EdgeInsets.all(displaySize.width/35),
        child: Text(
          '機能ガイドを閉じる',
          style: TextStyle(
            color: Colors.white,
            fontSize: FontSize.small,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
