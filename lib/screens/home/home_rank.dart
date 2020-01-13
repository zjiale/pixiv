import 'package:extended_image/extended_image.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:pixiv/common/config.dart';

class HomeRank extends StatefulWidget {
  final List _rankList;
  HomeRank(this._rankList);

  @override
  _HomeRankState createState() => _HomeRankState();
}

class _HomeRankState extends State<HomeRank> {
  Map<String, String> headers = Config.headers;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      height: ScreenUtil().setHeight(300.0),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget._rankList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 225.0,
            margin: EdgeInsets.only(right: 10.0),
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: ExtendedImage.network(
                      widget._rankList[index].work.image_urls.large,
                      headers: headers,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      colorBlendMode: BlendMode.srcOver,
                      color: Colors.black26),
                ),
                widget._rankList[index].work.page_count > 1
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            width: 40.0,
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5.0))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Icon(Icons.book, size: 13.0),
                                  Text(
                                      '${widget._rankList[index].work.page_count}',
                                      style: TextStyle(fontSize: 13.0))
                                ])),
                      )
                    : Container(),
                Positioned(
                    left: 10.0,
                    bottom: 10.0,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 160.0,
                            child: Text(
                              widget._rankList[index].work.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(-1, -1),
                                        blurRadius: 5)
                                  ]),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 10.0,
                                    backgroundImage:
                                        ExtendedNetworkImageProvider(
                                      widget._rankList[index].work.user
                                          .profile_image_urls.px_50x50,
                                      headers: headers,
                                    )),
                                SizedBox(width: 5.0),
                                Text(widget._rankList[index].work.user.name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                        shadows: [
                                          Shadow(
                                              color: Colors.black,
                                              offset: Offset(-1, -1),
                                              blurRadius: 5)
                                        ]))
                              ])
                        ])),
                Positioned(
                  right: 10.0,
                  bottom: 10.0,
                  child: LikeButton(size: 25.0),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
