import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:zikanri/controller/record_notifier.dart';
import 'package:zikanri/controller/theme_notifier.dart';
import 'package:zikanri/controller/user_data_notifier.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Splash.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
    await Hive.openBox('theme');
    await Hive.openBox('userData');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserDataNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => RecordNotifier(),
        ),
      ],
      child: MyApp(),
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
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterNotification = flutterLocalNotificationsPlugin;
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

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
