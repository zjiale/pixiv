import 'package:flutter/material.dart';

class TitleHeader extends StatefulWidget {
  final String imgUrl;
  final String title;
  final String check;

  TitleHeader({this.imgUrl, @required this.title, this.check = "查看更多"});

  @override
  _TitleHeaderState createState() => _TitleHeaderState();
}

class _TitleHeaderState extends State<TitleHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.imgUrl != null
                      ? Row(children: <Widget>[
                          Image.asset(widget.imgUrl, width: 20.0, height: 20.0),
                          SizedBox(width: 5.0)
                        ])
                      : Container(),
                  Text(widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/rankScreen');
            },
            child: Container(
                child: Row(children: <Widget>[
              Text(widget.check,
                  style: TextStyle(color: Color(0xFF008B8B), fontSize: 12.0)),
              Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.blue)
            ])),
          )
        ]);
  }
}
