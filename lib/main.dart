import 'package:flutter/material.dart';
import 'screens/homeScreens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Buget Ui',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: HomeScreens(),
    );
  }
}
