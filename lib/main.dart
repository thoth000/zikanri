import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Splash.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
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
