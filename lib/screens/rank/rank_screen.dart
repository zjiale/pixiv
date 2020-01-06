import 'package:flutter/material.dart';

class RankScreen extends StatefulWidget {
  @override
  _RankScreenState createState() => _RankScreenState();
}

class _RankScreenState extends State<RankScreen>
    with SingleTickerProviderStateMixin {
  List<Tab> _rankTab = <Tab>[
    Tab(text: '每日'),
    Tab(text: '男性热门'),
    Tab(text: '女性热门'),
    Tab(text: '原创'),
    Tab(text: '新人'),
    Tab(text: '每周'),
    Tab(text: '每月'),
    Tab(text: '过期排行榜')
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Text('排行榜'),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(48.0),
                    child: Material(
                        child: TabBar(
                      controller: _rankTabController,
                      tabs: _rankTab,
                      //设置tab是否可水平滑动
                      isScrollable: true,
                      //设置tab选中得颜色
                      labelColor: Colors.black,
                      //设置tab未选中得颜色
                      unselectedLabelColor: Colors.black45,
                    )))),
            body: TabBarView(
              controller: _rankTabController,
              children: _rankTab.map((Tab tab) {
                final String label = tab.text.toLowerCase();
                return Center(
                  child: Text(
                    'This is the $label tab',
                    style: const TextStyle(fontSize: 36),
                  ),
                );
              }).toList(),
            )));
  }
}
