import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarButton extends StatefulWidget {
  @override
  _AppBarButtonState createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Text('\u{E5C4}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(60.0),
                    color: Colors.white,
                    fontFamily: 'MaterialIcons',
                    shadows: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.1, 0.1),
                          blurRadius: 5.0)
                    ])),
          )
        ],
      ),
    );
  }
}
