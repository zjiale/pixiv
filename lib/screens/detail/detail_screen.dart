import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return SafeArea(
        child: Scaffold(
            body: Column(children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: ScreenUtil().setHeight(350.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.dribbble.com/users/383120/screenshots/9355233/media/c91de53e75aabb60a8f2b7b1aebada5e.png'),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0)
                  ])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  iconSize: 30.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ),
          Positioned(
            bottom: -10.0,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Container(
              height: 50.0,
              width: 50.0,
              color: Colors.purple,
            ),
          )
        ],
      )
    ])));
  }
}
