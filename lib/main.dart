import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pixiv/screens/home/home_screen.dart';
import 'package:pixiv/screens/rank/image_list.dart';
import 'package:pixiv/screens/rank/rank_screen.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixiv',
      routes: <String, WidgetBuilder>{
        '/homeScreen': (BuildContext context) => HomeScreen(),
        '/rankScreen': (BuildContext context) => RankScreen(),
      },
      home: ImageListItem(),
    );
  }
}
