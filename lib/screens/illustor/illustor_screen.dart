import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pixiv/screens/illustor/networking_page_header.dart';
import 'package:pixiv/widgets/title_header.dart';

class IllustorScreen extends StatefulWidget {
  @override
  _IllustorScreenState createState() => _IllustorScreenState();
}

class _IllustorScreenState extends State<IllustorScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _descKey = GlobalKey();
  bool _show = true;
  List<String> list;

  ScrollController _scrollController = new ScrollController();
  final Duration duration = const Duration(milliseconds: 300);

  String _desc =
      'ももこと申します。\r\n趣味は1眼で写真を撮ることとピアノを弾くことです！\r\n\r\nいつもコメント、ブクマありがとうございます！\r\n大変励みになっており、嬉しいかぎりです。\r\n\r\nマイピクは募集していません。\r\nメッセージも返さないことが多いのでご了承ください。\r\n\r\n◆Twitter\r\nhttps://twitter.com/momoco_haru\r\n\r\n◆Tumblr\r\nhttps://momocoharu.tumblr.com/\r\n\r\n\r\n個人使用範囲（アイコン、壁紙など）以外の加工、転載は禁止です。\r\n使用許可についてのお返事もしていません。\r\nPersonal use of image is limited to wallpaper and icon. \r\nReprinting and editing is strictly prohibited.\r\nI also do not respond on permission of its use';

  @override
  void initState() {
    //监听Widget是否绘制完毕
    WidgetsBinding.instance.addPostFrameCallback(_getSizes);
    super.initState();
  }

  _getSizes(_) {
    final double _descHeight = _descKey.currentContext.size.height;
    if (_descHeight >= 100.0) {
      list = _desc.split("\r\n");
      String a = list[0] + '\r\n' + list[1] + '\r\n';
      setState(() {
        _show = false;
        _desc = a;
      });
    }
  }

  Widget _manga() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(child: Container(color: Colors.green)),
          Text('测试测试', style: TextStyle(fontSize: 15.0)),
          Container(
            width: 150.0,
            child: Text('测试测试测试测试测试测试测试测试测试测试测试测试测试',
                style: TextStyle(fontSize: 13.0, color: Colors.black54),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
          Row(children: <Widget>[
            Icon(
              Icons.favorite,
              color: Colors.black54,
              size: 13.0,
            ),
            SizedBox(width: 3.0),
            Text(
              '123156',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600),
            )
          ])
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:
              CustomScrollView(controller: _scrollController, slivers: <Widget>[
        SliverPersistentHeader(
          pinned: true,
          delegate: NetworkingPageHeader(maxExtent: 150.0, minExtent: 80.0),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.only(top: 50.0, bottom: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'ももこ@3日目南ナ-42a',
                  style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 5.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.twitter,
                        color: Colors.grey,
                        size: 18.0,
                      ),
                      SizedBox(width: 5.0),
                      Text('momoco_haru',
                          style: TextStyle(fontSize: 15.0, color: Colors.grey))
                    ]),
                SizedBox(height: 10.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: '517',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '关注',
                                  style: TextStyle(color: Colors.grey))
                            ]),
                      ),
                      SizedBox(width: 10.0),
                      RichText(
                        text: TextSpan(
                            text: '92',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '好P友',
                                  style: TextStyle(color: Colors.grey))
                            ]),
                      )
                    ])
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
            child: Text(_desc, textAlign: TextAlign.center, key: _descKey),
          ),
        ),
        SliverToBoxAdapter(
          child: Offstage(
            offstage: _show,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _desc = list.join("\r\n");
                    _show = true;
                  });
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('查看更多', style: TextStyle(color: Colors.grey)),
                      SizedBox(width: 10.0),
                      Icon(Icons.keyboard_arrow_down)
                    ]),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TitleHeader(
              title: '插画作品',
              check: '168件作品',
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          sliver: SliverGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1.0,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('He\'d have you all unravel at the'),
                color: Colors.teal[100],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Heed not the rabble'),
                color: Colors.teal[200],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Sound of screams but the'),
                color: Colors.teal[300],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Who scream'),
                color: Colors.teal[400],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Revolution is coming...'),
                color: Colors.teal[500],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Revolution, they...'),
                color: Colors.teal[600],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TitleHeader(
              title: '漫画作品',
              check: '12件作品',
            ),
          ),
        ),
        SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            sliver: SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 0.7,
                children: <Widget>[_manga(), _manga()])),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: TitleHeader(
              title: '插画·漫画收藏',
              check: '全部',
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          sliver: SliverGrid.count(
            crossAxisCount: 3,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1.0,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('He\'d have you all unravel at the'),
                color: Colors.teal[100],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Heed not the rabble'),
                color: Colors.teal[200],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Sound of screams but the'),
                color: Colors.teal[300],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Who scream'),
                color: Colors.teal[400],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Revolution is coming...'),
                color: Colors.teal[500],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: const Text('Revolution, they...'),
                color: Colors.teal[600],
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 50.0,
          ),
        )
      ])),
    );
  }
}
