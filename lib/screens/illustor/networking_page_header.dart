import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pixiv/widgets/appbar_btn.dart';

class NetworkingPageHeader implements SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final Duration duration = const Duration(milliseconds: 300);

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          'assets/images/timg.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black54],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        Positioned(
          left: 16.0,
          top: 16.0,
          child: AppBarButton(
              title: AnimatedOpacity(
            duration: duration,
            opacity: titleOpacity(shrinkOffset) <= 0 ? 1.0 : 0.0,
            child: Row(children: <Widget>[
              CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1600553076,1284989575&fm=26&gp=0.jpg')),
              SizedBox(width: 5.0),
              Text(
                '测试测试测试测试测试',
                style: TextStyle(color: Colors.white),
              )
            ]),
          )),
        ),
        Positioned(
          bottom: -40.0,
          child: Transform.scale(
            scale: titleOpacity(shrinkOffset),
            child: Opacity(
              opacity: titleOpacity(shrinkOffset) > 0
                  ? titleOpacity(shrinkOffset)
                  : 0.0,
              child: ClipOval(
                  child: Container(
                      width: 80.0, height: 80.0, color: Colors.yellow)),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    double _opacity = 1.0 - max(0.0, shrinkOffset) / (maxExtent - minExtent);
    if (_opacity < 0) return 0.0;
    return _opacity;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
