import 'package:flutter/material.dart';

class UserDesc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding: EdgeInsets.only(left: 30.0),
      child: Row(
        children: <Widget>[
          CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1600553076,1284989575&fm=26&gp=0.jpg')),
          SizedBox(width: 20.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Borderland_',
                  style:
                      TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: Colors.red)),
                  child: Text('关于pixiv高级会员',
                      style: TextStyle(fontSize: 12.0, color: Colors.red)),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
