import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Splash.dart';
import 'data.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: ChangeNotifierProvider(
        create: (_) => UserDataNotifier(),
        child: ChangeNotifierProvider(
          create: (_) => RecordNotifier(),
          child: ChangeNotifierProvider(
            create: (_) => ReloadNotifier(),
            child: MyApp(),
          ),
        ),
      ),
    ),
  );
}

/*Future a()async{
  await Hive.initFlutter();
  await Hive.openBox('theme');
  await Hive.openBox('userData');
  await Hive.box('theme').clear();
  await Hive.box('userData').clear();
}*/

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ジカンリ',
      theme: Provider.of<ThemeNotifier>(context).buildTheme(),
      home: SplashPage(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }
}
