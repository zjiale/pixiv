import 'package:flutter/material.dart';

class TitleHeader extends StatefulWidget {
  final String imgUrl;
  final String title;

  TitleHeader(this.imgUrl, this.title);

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
                  Image.asset(widget.imgUrl, width: 20.0, height: 20.0),
                  SizedBox(width: 5.0),
                  Text(widget.title,
                      style: TextStyle(fontWeight: FontWeight.bold))
                ]),
          ),
          Container(
              child: Row(children: <Widget>[
            Text('查看更多',
                style: TextStyle(color: Color(0xFF008B8B), fontSize: 12.0)),
            Icon(Icons.arrow_forward_ios, size: 15.0, color: Colors.blue)
          ]))
        ]);
  }
}
