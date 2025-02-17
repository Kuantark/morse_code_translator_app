import 'dart:io';
import 'package:flutter/material.dart';
import 'package:morse_code_flutter/pages/home_page.dart';

void main() async {
  // const String envFileName =
  //     String.fromEnvironment('ENV_FILE', defaultValue: ".env.production");
  // await dotenv.load(fileName: envFileName);
  // initializeDateFormatting('zh_TW', null);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  @override
  void initState() {
    super.initState();
    // APIManager.logoutNotifier.addListener(_handleLogout);

    // final lifecycleObserver = AppLifecycleObserver();
    // WidgetsBinding.instance.addObserver(lifecycleObserver);

    // AnalyticsManager.getInstance();
  }

  @override
  void dispose() {
    // APIManager.logoutNotifier.removeListener(_handleLogout);
    super.dispose();
  }

  void _handleLogout() {
    // if (APIManager.logoutNotifier.value) {
    //   APIManager.logoutNotifier.value = false;
    //   Navigator.of(routeObserver.navigator!.context)
    //       .pushReplacementNamed('/login');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Morse Code',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: '/',
      navigatorObservers: [routeObserver],
      routes: {
        '/': (context) => HomePage(),
      },
    );
  }
}
