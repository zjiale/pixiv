import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pixiv/screens/rank/top_image.dart';
// import 'package:pixiv/screens/rank/image_list.dart';

class RankScreen extends StatefulWidget {
  @override
  _RankScreenState createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen>
    with SingleTickerProviderStateMixin {
  List _rankTab = [
    {"text": "日榜", "type": "daily"},
    {"text": "新人", "type": "rookie"},
    {"text": "周榜", "type": "weekly"},
    {"text": "月榜", "type": "monthly"},
    {"text": "过去排行榜", "type": "other"},
  ];

  TabController _rankTabController;

  @override
  void initState() {
    super.initState();
    _rankTabController = TabController(vsync: this, length: _rankTab.length);
  }

  @override
  void dispose() {
    super.dispose();
    _rankTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoadingMoreCustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          // 是否附着在头部
          pinned: true,
          title: Text('排行榜'),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Material(
                  color: Colors.white,
                  child: TabBar(
                    controller: _rankTabController,
                    tabs: _rankTab
                        .map((e) => Tab(child: Text(e["text"])))
                        .toList(),
                    //设置tab选中得颜色
                    labelColor: Colors.black,
                    //设置tab未选中得颜色
                    unselectedLabelColor: Colors.black45,
                  ))),
        ),
        SliverFillRemaining(
            child: TabBarView(
          controller: _rankTabController,
          children: _rankTab.map((e) {
            return TopImage(e["type"]);
          }).toList(),
        ))
      ],
    ));
  }
}
