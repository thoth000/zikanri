import 'package:flutter/material.dart';
import 'Splash.dart';
import 'package:flutter/services.dart';
import 'data.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            child: MyApp(),
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
