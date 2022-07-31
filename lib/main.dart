import 'package:flutter/material.dart';
import 'package:quiz_app_test/screen/screen_home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My quiz app',
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: HomeScreen(),
    );
  }
}
