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
import 'package:pixiv/screens/detail/illuser_desc.dart';
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
    with SingleTickerProviderStateMixin {
  final String _type = 'member_illust';

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

  Widget _imageInfo(List snapshot, List snapshot1) {
    var _query = snapshot.first;

    // 图片显示以及底部导航栏的显示
    Size _deviceSize = MediaQuery.of(context).size;
    double _limitHeight = _query.height * _deviceSize.width / _query.width;
    int num = _query.metadata != null ? _query.metadata.pages.length : 1;
    // 图片的总共长度
    double _totalHeight = _limitHeight * num;
    double _difference = _totalHeight - _deviceSize.height;

    return Stack(
      children: <Widget>[
        Container(
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              _imageList(context, snapshot),
              IlluserDesc(_query),
              Divider(height: 1.0, color: Colors.grey),
              SizedBox(height: 18.0),
              Container(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                color: Colors.lightBlue,
                                size: ScreenUtil().setSp(20.0))
                          ],
                        ))
                      ]))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
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
            onTap: () {},
            child: Opacity(
              opacity: (_showBottom != null ? _showBottom : (_difference <= 20))
                  ? 1.0
                  : 0.0,
              child: Container(
                height: 60.0,
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SlideTransition(
                        position: _slideAnimation,
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 25.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      SlideTransition(
                          position: _slideAnimation1,
                          child: Row(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(_query.title,
                                              maxLines: _maxLine,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black54)),
                                          SizedBox(
                                              height:
                                                  ScreenUtil().setHeight(8.0)),
                                          Text(_query.user.name,
                                              style: TextStyle(
                                                  fontSize:
                                                      ScreenUtil().setSp(20.0),
                                                  color: Colors.black45))
                                        ]))
                              ]))
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
