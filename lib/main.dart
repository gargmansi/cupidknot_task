import 'package:cupidknot_task/register.dart';
import 'package:cupidknot_task/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(fontFamily: "Montserrat", colorScheme: ColorScheme.dark()),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
