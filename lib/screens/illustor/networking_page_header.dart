import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    print(1.0 - max(0.0, shrinkOffset) / (maxExtent - minExtent));
    return 1.0 - max(0.0, shrinkOffset) / (maxExtent - minExtent);
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
