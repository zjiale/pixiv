import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixiv/widgets/list_item.dart';
import 'package:pixiv/widgets/user_desc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> _tabs = ["插画", "漫画", "小说"];
  List _type = [
    {"icon": Icons.home, "text": "主页"},
    {"icon": Icons.new_releases, "text": "最新"},
    {"icon": Icons.search, "text": "搜索"}
  ];

  Widget _buildActions(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(_type[index]["icon"], color: Colors.white, size: 25.0),
            SizedBox(height: 2.0),
            Text(_type[index]["text"], style: TextStyle(fontSize: 10.0))
          ]),
    );
  }

  Widget _buildTabs(int index) {
    return GestureDetector(
      onTap: () {
        if (_selectedIndex == index) return;
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
        child: Text(_tabs[index],
            style: TextStyle(
                color: _selectedIndex == index ? Colors.white : Colors.grey)),
        decoration: _selectedIndex == index
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(30.0), color: Colors.blue)
            : BoxDecoration(),
      ),
    );
  }

  Widget _buildHomeType() {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
        child: Column(children: <Widget>[
          ListItem(Icons.home, '主页', () {
            print('to 主页');
          }),
          ListItem(Icons.new_releases, '最新', () {
            print('to 最新');
          }),
          ListItem(Icons.search, '搜索', () {
            print('to 搜索');
          })
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text('主页'),
            actions: _type
                .asMap()
                .entries
                .map(
                  (MapEntry map) => _buildActions(map.key),
                )
                .toList()),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            children: <Widget>[
              UserDesc(),
              SizedBox(height: 40.0),
              _buildHomeType(),
              Divider(
                color: Color(0xFF778899),
                height: 1.0,
              )
            ],
          ),
        ),
        body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
          Container(
            height: 50.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0)
            ]),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _tabs
                    .asMap()
                    .entries
                    .map(
                      (MapEntry map) => _buildTabs(map.key),
                    )
                    .toList()),
          ),
          SizedBox(height: 20.0),
          Container(
            height: 200.0,
            color: Colors.blue,
            padding: EdgeInsets.only(left: 10.0),
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(children: <Widget>[
                          Icon(FontAwesomeIcons.crown),
                          Text(
                            '排行榜',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ]),
                      )
                    ])
              ],
            ),
          )
        ]),
      ),
    );
  }
}
