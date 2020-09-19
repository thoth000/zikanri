//packages
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Size displaySize;
FlutterLocalNotificationsPlugin flutterNotification;

class FontSize {
  static double xxsmall = displaySize.width / 30;
  static double xsmall = displaySize.width / 25;
  static double small = displaySize.width / 20;
  static double midium = displaySize.width / 17;
  static double large = displaySize.width / 15.5;
  static double xlarge = displaySize.width / 12;
  static double xxlarge = displaySize.width / 8;
  static double big = displaySize.width / 6;
}

class Vib {
  static void select() {
    Vibration.vibrate(duration: 30);
  }

  static void decide() {
    Vibration.vibrate(duration: 50);
  }

  static void add() {
    Vibration.vibrate(duration: 150);
  }

  static void shortCut() {
    Vibration.vibrate(pattern: [0, 50, 100, 50, 100, 50]);
  }
}

final List<int> iconList = [
  57746,
  57680,
  58726,
  59601,
  58128,
  58699,
  58378,
  58168,
  59677,
  58937,
  58917,
  58143,
  59497,
  60231,
  60227,
  60236,
  59471,
  59540,
  58373,
  58693,
  57388,
  60222,
  60224,
  59517,
  59596,
  58386,
  58899,
];

final List<int> newIconList = [
  Icons.access_time.codePoint,
  Icons.edit.codePoint,
  Icons.directions_run.codePoint,
  Icons.store.codePoint,
  Icons.headset.codePoint,
  Icons.local_library.codePoint,
  Icons.palette.codePoint,
  Icons.videogame_asset.codePoint,
  Icons.pets.codePoint,
  Icons.ondemand_video.codePoint,
  Icons.chat.codePoint,
  Icons.computer.codePoint,
  Icons.build.codePoint,
  Icons.kitchen.codePoint,
  Icons.fitness_center.codePoint,
  Icons.spa.codePoint,
  Icons.account_balance.codePoint,
  Icons.explore.codePoint,
  Icons.music_note.codePoint,
  Icons.local_florist.codePoint,
  Icons.movie.codePoint,
  Icons.beach_access.codePoint,
  Icons.local_play.codePoint,
  Icons.favorite.codePoint,
  Icons.local_grocery_store.codePoint,
  Icons.local_see.codePoint,
  Icons.time_to_leave.codePoint,
];

const List<int> achiveM = [500, 1000, 3000, 5000, 10000];
const List<int> achiveD = [1, 3, 7, 30, 100];

//BaseColor
//単色をベースにしていく
//Color数=>14
List<List<Color>> baseColors = const [
  [Color(0XFF39BAE8), Color(0XFF0000A1)], //青
  [Color(0XFFef473a), Color(0XFFcb2d3e)], //赤
  [Color(0XFF08ffc8), Color(0XFF204969)], //緑
  [Color(0xFFFFFFFF), Color(0xFF000000)], //モノクロ
  [Color(0XFFffcccc), Color(0XFFcaabd8)], //ピンク
  [Color(0XFFffe259), Color(0XFFffa751)], //マンゴー
  [Color(0XFFFFFDE4), Color(0XFF005AA7)], //白青
  [Color(0XFFfffbd5), Color(0XFFb20a2c)], //白赤
  [Color(0XFFe4e4d9), Color(0XFF215f00)], //白緑
  [Color(0XFF00ecbc), Color(0XFF007adf)], //風
  [Color(0XFF21D4FD), Color(0XFFB721FF)], //紫グラ
  [Color(0XFFDBE6F6), Color(0XFFC5796D)], //ジュピター
  [Color(0XFF81FBB8), Color(0XFF28C76F)], //鮮緑
  [Color(0XFF4776E6), Color(0XFF8E54E9)], //紫
];
