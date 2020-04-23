import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Splash.dart';
import 'data.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('theme');
  await Hive.openBox('userData');
  await Hive.box('theme').clear();
  await Hive.box('userData').clear();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (_) => ThemeNotifier(),
        child: ChangeNotifierProvider(
          create: (_) => UserDataNotifier(),
          child: ChangeNotifierProvider(
            create: (_) => RecordNotifier(),
            child: ChangeNotifierProvider(
              create: (_) => ReloadNotifier(),
              child: MyApp()),
          ),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ジカンリ',
      theme: Provider.of<ThemeNotifier>(context).buildTheme(),
      home: SplashPage(),
    );
  }
}
