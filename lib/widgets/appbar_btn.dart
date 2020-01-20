import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarButton extends StatefulWidget {
  final Widget title;
  AppBarButton({this.title});

  @override
  _AppBarButtonState createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween, 10,20
      children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back, color: Colors.white)),
        SizedBox(width: 5.0),
        widget.title
      ],
    );
  }
}
