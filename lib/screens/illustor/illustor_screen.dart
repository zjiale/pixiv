import 'package:flutter/material.dart';
import 'package:pixiv/screens/illustor/networking_page_header.dart';

class IllustorScreen extends StatefulWidget {
  @override
  _IllustorScreenState createState() => _IllustorScreenState();
}

class _IllustorScreenState extends State<IllustorScreen>
    with SingleTickerProviderStateMixin {
  double _top = 140.0;

  ScrollController _scrollController = new ScrollController();
  AnimationController _controller;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(controller: _scrollController, slivers: <Widget>[
      SliverPersistentHeader(
        pinned: true,
        delegate: NetworkingPageHeader(maxExtent: 250.0, minExtent: 150.0),
      ),
      SliverFixedExtentList(
        itemExtent: 50.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 9)],
              child: Text('List Item $index'),
            );
          },
        ),
      ),
    ]));
  }
}
