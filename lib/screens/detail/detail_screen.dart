import 'dart:ui';

import 'package:async/async.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pixiv/api/CommonServices.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/detail_model.dart';
import 'package:pixiv/model/member_illust_model.dart';
import 'package:pixiv/widgets/follow_btn.dart';

class DetailScreen extends StatefulWidget {
  final String type;
  final int id;
  final int userId;
  DetailScreen(this.type, this.id, this.userId);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  final String _type = 'member_illust';

  // 滚动监听相关属性
  final GlobalKey _imageGlobalKey = GlobalKey();
  AsyncMemoizer _memoizer = AsyncMemoizer();
  ScrollController _scrollController = new ScrollController();
  ScrollController _descController = new ScrollController();
  // 判断是否首次进入详情页显示bottom
  bool _showBottom;
  // 只用于记录滚动监听是否多次
  bool _show = true;

  // window对象中视窗单位为px，所以这里需要除以像素数得到dp
  double viewport = window.physicalSize.height / window.devicePixelRatio;
  double padding = window.padding.top / window.devicePixelRatio;

  // 动画相关属性
  AnimationController _controller;
  AnimationController _headerController;
  Animation<Offset> _slideAnimation;
  Animation<Offset> _headerSlideAnimation;
  final Duration duration = const Duration(milliseconds: 300);

  // 图片简介相关属性
  final int _maxLine = 2;
  double _sigmaX, _sigmaY = 0;
  Map<String, String> headers = Config.headers;

  // 是否监听模糊层
  bool _absorb = false;

  // bottom控件相关属性
  bool _isCollasped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _headerController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _slideAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.88), end: Offset(0.0, 0.0))
            .animate(_controller);
    _headerSlideAnimation =
        Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(-0.1, 0.0))
            .animate(_headerController);
    _slideListener();
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_scrollController.dispose
    _scrollController.dispose();
    _descController.dispose();
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
      if (_scrollController.offset >= _scrollNum && _show) {
        setState(() {
          _headerController.forward();
          _showBottom = false;
          _show = false;
        });
      } else if (_scrollController.offset < _scrollNum && !_show) {
        setState(() {
          _headerController.reverse();
          _showBottom = true;
          _show = true;
        });
      }
    });
  }

  _load() {
    return _memoizer.runOnce(() async {
      return Future.wait([_initDetailInfo(), _initUserInfo()]);
    });
  }

  Future _initDetailInfo() {
    return CommonServices().getDetailInfo(widget.type, widget.id).then((res) {
      if (res.statusCode == 200) {
        DetailModel _bean = DetailModel.fromJson(res.data);
        if (_bean.status == "success") {
          return _bean.response;
        }
      }
    });
  }

  Future _initUserInfo() {
    return CommonServices().getDetailInfo(_type, widget.userId).then((res) {
      if (res.statusCode == 200) {
        MemberIllustModel _bean = MemberIllustModel.fromJson(res.data);
        if (_bean.status == "success") {
          _bean.response.removeRange(3, _bean.response.length);
          return _bean.response;
        }
      }
    });
  }

  Widget _imageList(BuildContext context, List snapshot) {
    double deviceWidth = MediaQuery.of(context).size.width;
    List<Widget> list = [];

    if (snapshot.first.metadata == null) {
      list.add(Container(
          width: double.infinity,
          height: snapshot.first.height * deviceWidth / snapshot.first.width,
          child: ExtendedImage.network(snapshot.first.image_urls.medium,
              headers: headers,
              fit: BoxFit.contain,
              alignment: Alignment.topCenter)));
    } else {
      for (var imgs in snapshot.first.metadata.pages) {
        list.add(Container(
            width: double.infinity,
            height: snapshot.first.height * deviceWidth / snapshot.first.width,
            child: ExtendedImage.network(imgs.image_urls.medium,
                headers: headers,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter)));
      }
    }

    return Column(key: _imageGlobalKey, children: list);
  }

  Widget _userImageList(List imgList) {
    List<Widget> list = [];

    for (var i = 0; i < imgList.length; i++) {
      list.add(Expanded(
        child: Container(
            width: ScreenUtil().setWidth(250.0),
            height: ScreenUtil().setHeight(200.0),
            margin: i == 1
                ? EdgeInsets.symmetric(horizontal: 3.0)
                : EdgeInsets.zero,
            child: ExtendedImage.network(imgList[i].image_urls.px_480mw,
                headers: headers,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter)),
      ));
    }

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, children: list),
    );
  }

  Widget _illustor(var _query, var snapshot1) {
    return Container(
        height: ScreenUtil().setHeight(400.0),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      CircleAvatar(
                          radius: 16.0,
                          backgroundImage: NetworkImage(
                              _query.user.profile_image_urls.px_50x50,
                              headers: headers)),
                      SizedBox(width: 10.0),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                            Text(_query.user.name,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                          ]))
                    ]),
                    FollowButton()
                  ]),
              SizedBox(height: 18.0),
              _userImageList(snapshot1),
              SizedBox(height: 18.0),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('查看个人简介',
                      style: TextStyle(
                          color: Color(0xFF5F9EA0),
                          fontSize: ScreenUtil().setSp(24.0),
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 5.0),
                  Icon(Icons.arrow_forward_ios,
                      color: Colors.lightBlue, size: ScreenUtil().setSp(20.0))
                ],
              ))
            ]));
  }

  Widget _illustorDesc(var _query, var snapshot1) {
    return Container(
        height: ScreenUtil().setHeight(800.0),
        width: ScreenUtil().setWidth(750.0),
        // padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 20.0),
        color: Colors.white,
        child: ListView(controller: _descController, children: <Widget>[
          _illustHeader(_query),
          _illustor(_query, snapshot1)
        ]));
  }

  Widget _illustHeader(var _query) {
    final List _tags = _query.tags;

    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 10.0),
                child: Icon(
                  _isCollasped
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  size: ScreenUtil().setSp(60.0),
                  color: Colors.black54,
                )),
            SlideTransition(
              position: _headerSlideAnimation,
              child: Row(children: <Widget>[
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
                          SizedBox(height: ScreenUtil().setHeight(8.0)),
                          Text(_query.user.name,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20.0),
                                  color: Colors.black45))
                        ]))
              ]),
            )
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
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
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " 喜欢"),
                  ]),
              textDirection: TextDirection.ltr,
            )
          ]),
          SizedBox(height: 10.0),
          Wrap(
            spacing: 5.0,
            // runSpacing: 3.0,
            children: _tags
                .map((e) => Chip(
                      backgroundColor: Colors.orangeAccent,
                      label: Text('#$e', style: TextStyle(color: Colors.white)),
                    ))
                .toList(),
          ),
          SizedBox(height: 10.0),
          Container(
              padding: EdgeInsets.only(right: 10.0),
              width: double.infinity,
              child: Text(_query.caption,
                  style: TextStyle(color: Colors.black54))),
        ],
      ),
    );
  }

  Widget _imageInfo(List snapshot, List snapshot1) {
    var _query = snapshot.first;

    // 图片显示以及底部导航栏的显示
    Size _deviceSize = MediaQuery.of(context).size;
    double _limitHeight = _query.height * _deviceSize.width / _query.width;
    int num = _query.metadata != null ? _query.metadata.pages.length : 1;
    // 图片的总共长度
    double _totalHeight = _limitHeight * num;
    // double _difference = _totalHeight - _deviceSize.height;

    return Stack(
      children: <Widget>[
        // 监听是否有点击模糊层
        Listener(
          onPointerUp: (event) {
            if (_absorb == false) return;
            setState(() {
              _isCollasped = !_isCollasped;
              _sigmaX = 0;
              _sigmaY = 0;
              _absorb = false;
              _descController.jumpTo(0.0);
            });
            _controller.reverse();
          },
          child: AbsorbPointer(
            absorbing: _absorb,
            child: Container(
              child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  _imageList(context, snapshot),
                  _illustHeader(_query),
                  Divider(height: 1.0, color: Colors.grey),
                  SizedBox(height: 18.0),
                  _illustor(_query, snapshot1)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: GestureDetector(
            onTap: () {
              if (_isCollasped) {
                return;
              } else {
                setState(() {
                  _isCollasped = !_isCollasped;
                  _sigmaX = 3;
                  _sigmaY = 3;
                  _absorb = true;
                });
                _controller.forward();
              }
            },
            child: Offstage(
                offstage: _totalHeight > _deviceSize.height ? false : true,
                child: BackdropFilter(
                    filter:
                        new ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                    child: SlideTransition(
                        position: _slideAnimation,
                        child: _illustorDesc(_query, snapshot1)))),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text('\u{E5C4}',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(60.0),
                        color: Colors.white,
                        fontFamily: 'MaterialIcons',
                        shadows: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(0.1, 0.1),
                              blurRadius: 5.0)
                        ])),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: FutureBuilder(
                future: _load(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: SpinKitChasingDots(
                              color: Colors.orange, size: 30.0));
                    case ConnectionState.done:
                      return _imageInfo(snapshot.data[0], snapshot.data[1]);
                    default:
                      return null;
                  }
                })));
  }
}
