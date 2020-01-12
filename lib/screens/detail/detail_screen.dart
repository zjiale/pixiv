import 'dart:ui';

import 'package:async/async.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pixiv/api/CommonServices.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/detail_model.dart';

class DetailScreen extends StatefulWidget {
  final String type;
  final int id;
  DetailScreen(this.type, this.id);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  // 滚动监听相关属性
  final GlobalKey _imageGlobalKey = GlobalKey();
  AsyncMemoizer _memoizer = AsyncMemoizer();
  ScrollController _scrollController = new ScrollController();
  bool _showBottom;
  // window对象中视窗单位为px，所以这里需要除以像素数得到dp
  double viewport = window.physicalSize.height / window.devicePixelRatio;
  double padding = window.padding.top / window.devicePixelRatio;

  // 动画相关属性
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<Offset> _slideAnimation1;
  final Duration duration = const Duration(milliseconds: 300);

  // 图片简介相关属性
  int _maxLine = 2;
  Map<String, String> headers = Config.headers;

  @override
  void initState() {
    super.initState();
    _initDetailInfo();
    _controller = AnimationController(vsync: this, duration: duration);
    _slideAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-1.0, 0.0))
            .animate(_controller);
    _slideAnimation1 =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-0.3, 0.0))
            .animate(_controller);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _slideListener();
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_scrollController.dispose
    _scrollController.dispose();
    super.dispose();
  }

  // 监听图片是否超过视窗
  void _slideListener() {
    //监听滚动事件，打印滚动位置
    _scrollController.addListener(() {
      double _scrollNum = _imageGlobalKey.currentContext.size.height -
          viewport +
          padding +
          60.0;
      if (_scrollController.offset >= _scrollNum) {
        setState(() {
          _controller.forward();
          _showBottom = false;
          _maxLine = 1;
        });
      } else {
        setState(() {
          _controller.reverse();
          _showBottom = true;
          _maxLine = 2;
        });
      }
    });
  }

  Future _initDetailInfo() {
    return _memoizer.runOnce(() async {
      return CommonServices().getDetailInfo(widget.type, widget.id).then((res) {
        if (res.statusCode == 200) {
          DetailModel _bean = DetailModel.fromJson(res.data);
          if (_bean.status == "success") {
            return _bean.response;
          }
        }
      });
    });
  }

  Widget _imageList(BuildContext context, AsyncSnapshot snapshot) {
    double deviceWidth = MediaQuery.of(context).size.width;
    List<Widget> list = [];

    if (snapshot.data.first.metadata == null) {
      list.add(Container(
          width: double.infinity,
          height: snapshot.data.first.height *
              deviceWidth /
              snapshot.data.first.width,
          child: ExtendedImage.network(snapshot.data.first.image_urls.medium,
              headers: headers,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter)));
    } else {
      for (var imgs in snapshot.data.first.metadata.pages) {
        list.add(Container(
            width: double.infinity,
            height: snapshot.data.first.height *
                deviceWidth /
                snapshot.data.first.width,
            child: ExtendedImage.network(imgs.image_urls.medium,
                headers: headers,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter)));
      }
    }

    return Column(key: _imageGlobalKey, children: list);
  }

  Widget _imageInfo(AsyncSnapshot snapshot) {
    Size _deviceSize = MediaQuery.of(context).size;
    var _query = snapshot.data.first;
    double _limitHeight = _query.height * _deviceSize.width / _query.width;
    int num = _query.metadata != null ? _query.metadata.pages.length : 1;
    // 图片的总共长度
    double _totalHeight = _limitHeight * num;

    return Stack(
      children: <Widget>[
        Container(
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              _imageList(context, snapshot),
              Container(
                height: ScreenUtil().setHeight(550.0),
                padding: EdgeInsets.only(left: 20.0, top: 5.0),
                child: Column(
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                              radius: 16.0,
                              backgroundImage: NetworkImage(
                                  _query.user.profile_image_urls.px_50x50,
                                  headers: headers)),
                          SizedBox(width: 10.0),
                          Container(
                              width: ScreenUtil().setWidth(550.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(_query.title,
                                        maxLines: _maxLine,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54)),
                                    SizedBox(
                                        height: ScreenUtil().setHeight(8.0)),
                                    Text(_query.user.name,
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(20.0),
                                            color: Colors.black45))
                                  ]))
                        ]),
                    SizedBox(height: 18.0),
                    Row(children: <Widget>[
                      Text('${_query.created_time}',
                          style: TextStyle(
                              color: Color(0xFF5F9EA0),
                              fontSize: ScreenUtil().setSp(24.0))),
                      SizedBox(width: 10.0),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Color(0xFF5F9EA0),
                                fontSize: ScreenUtil().setSp(24.0)),
                            children: [
                              TextSpan(
                                  text: "${_query.stats.views_count}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " 阅读"),
                            ]),
                        textDirection: TextDirection.ltr,
                      ),
                      SizedBox(width: 10.0),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Color(0xFF5F9EA0),
                                fontSize: ScreenUtil().setSp(24.0)),
                            children: [
                              TextSpan(
                                  text:
                                      "${_query.stats.favorited_count.public + _query.stats.favorited_count.private}",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: " 喜欢"),
                            ]),
                        textDirection: TextDirection.ltr,
                      )
                    ]),
                    SizedBox(height: 18.0),
                    Wrap(spacing: 10.0, runSpacing: 10.0, children: <Widget>[
                      Container(height: 50.0, width: 100.0, color: Colors.blue)
                    ]),
                  ],
                ),
              ),
              Container(height: 300.0, color: Colors.blue)
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.greenAccent,
                    );
                  });
            },
            child: Opacity(
              opacity: (_showBottom != null
                      ? _showBottom
                      : (_totalHeight > _deviceSize.height))
                  ? 1.0
                  : 0.0,
              child: Container(
                height: 60.0,
                width: ScreenUtil().setWidth(750.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                color: Colors.yellow,
                child: Row(children: <Widget>[
                  SlideTransition(
                    position: _slideAnimation,
                    child: Icon(
                      Icons.arrow_drop_up,
                      size: 25.0,
                    ),
                  ),
                  SlideTransition(
                    position: _slideAnimation1,
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                            radius: 20.0,
                            backgroundImage: NetworkImage(
                                'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1600553076,1284989575&fm=26&gp=0.jpg')),
                        SizedBox(width: 10.0),
                        Container(
                          width: ScreenUtil().setWidth(550.0),
                          child: Text(
                            '啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊刷煞阿萨大大实打实的',
                            maxLines: _maxLine,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return SafeArea(
        child: Scaffold(
            body: FutureBuilder(
                future: _initDetailInfo(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: SpinKitChasingDots(
                              color: Colors.orange, size: 30.0));
                    case ConnectionState.done:
                      return _imageInfo(snapshot);
                    default:
                      return null;
                  }
                })));
  }
}
