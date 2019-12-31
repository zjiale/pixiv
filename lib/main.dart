import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pixiv/screens/home_screen.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixiv',
      home: HomeScreen(),
    );
  }
}
