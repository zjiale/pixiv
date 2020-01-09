import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixiv/api/CommonServices.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/illust_rank_model.dart';
import 'package:pixiv/model/case_model.dart';
import 'package:pixiv/model/image_list_model.dart';
import 'package:pixiv/screens/home/home_case.dart';
import 'package:pixiv/screens/home/home_latest.dart';
import 'package:pixiv/widgets/list_item.dart';
import './title_header.dart';
import './user_desc.dart';
import './home_rank.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List _rankList = [];
  List _case = [];
  List _latest = [];
  List<String> _tabs = ["插画", "漫画", "小说"];
  List _type = [
    {"icon": Icons.home, "text": "主页"},
    {"icon": Icons.search, "text": "搜索"}
  ];

  Map<String, String> headers = Config.headers;

  Widget _buildActions(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(_type[index]["icon"],
                color: Colors.white, size: ScreenUtil().setSp(35.0)),
            SizedBox(height: 2.0),
            Text(_type[index]["text"],
                style: TextStyle(fontSize: ScreenUtil().setSp(20.0)))
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
  void initState() {
    super.initState();
    _initRanking();
    _initCase();
    _initLatest();
  }

  void _initRanking() {
    CommonServices().getRanking('illust', 'daily', 1).then((res) {
      if (res.statusCode == 200) {
        IllustRankModel _bean = IllustRankModel.fromJson(res.data);
        if (_bean.status == "success") {
          List contents = _bean.response.first.works;
          contents.removeRange(9, _bean.response.first.works.length);
          setState(() {
            _rankList = contents;
          });
        }
      }
    });
  }

  void _initLatest() {
    CommonServices().getLatest((ImageModel _bean) {
      if (_bean.status == "success") {
        setState(() {
          _latest = _bean.response;
        });
      }
    });
  }

  void _initCase() {
    CommonServices().getCase((CaseModel _bean) {
      if (_bean.error == false) {
        List contents = _bean.body;
        contents.removeRange(8, _bean.body.length);
        setState(() {
          _case = contents;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

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
            height: ScreenUtil().setHeight(360.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: <Widget>[
                TitleHeader('assets/images/crown.png', '排行榜'),
                HomeRank(_rankList)
              ],
            ),
          ),
          SizedBox(height: 30.0),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TitleHeader('assets/images/case.png', '插画特辑')),
          HomeCase(_case),
          SizedBox(height: 30.0),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: TitleHeader('assets/images/new.png', '最新作品')),
          HomeLatest(_latest)
        ]),
      ),
    );
  }
}
