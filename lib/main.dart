import 'package:flutter/material.dart';
import 'constant/meterial_white.dart';
import 'home_page.dart';
import 'screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: white,
      ),
      // home: HomePage(),
      home: AuthScreen(),
    );
  }
}
