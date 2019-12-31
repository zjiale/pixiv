import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> _tabs = ["插画", "漫画", "小说"];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主页'),
        leading: IconButton(icon: Icon(Icons.menu, color: Colors.white)),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.home, color: Colors.white, size: 25.0),
                  SizedBox(height: 2.0),
                  Text('主页', style: TextStyle(fontSize: 10.0))
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.new_releases, color: Colors.white, size: 25.0),
                  SizedBox(height: 2.0),
                  Text('最新', style: TextStyle(fontSize: 10.0))
                ]),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.search, color: Colors.white, size: 25.0),
                  SizedBox(height: 2.0),
                  Text('搜索', style: TextStyle(fontSize: 10.0))
                ]),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[DrawerHeader(child: Text('header'.toUpperCase()))],
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
        )
      ]),
    );
  }
}
