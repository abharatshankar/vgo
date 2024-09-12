import 'package:flutter/material.dart';
import 'package:vgo_flutter_app/src/utils/utils.dart';
import 'package:vgo_flutter_app/src/view/splash_screen_view.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    loggerNoStack.e('MyApp');

    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreenView(),
    );
  }
}
