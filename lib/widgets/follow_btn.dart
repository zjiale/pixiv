import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowButton extends StatefulWidget {
  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool _isFollow = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _isFollow = !_isFollow;
          });
        },
        child: _isFollow
            ? Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: new Border.all(color: Colors.lightBlue, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.lightBlue),
                child: Text('关注中',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(23.0))))
            : Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: new Border.all(color: Colors.lightBlue, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Text('关注',
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: ScreenUtil().setSp(23.0)))));
  }
}
