import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pixiv/api/CommonServices.dart';
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
  ScrollController _scrollController = new ScrollController();
  bool _showBottom = true;

  // 动画相关属性
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<Offset> _slideAnimation1;
  final Duration duration = const Duration(milliseconds: 300);

  // 图片简介相关属性
  List _detail;
  int _maxLine = 2;

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
    // window对象中视窗单位为px，所以这里需要除以像素数得到dp
    double viewport = window.physicalSize.height / window.devicePixelRatio;
    double padding = window.padding.top / window.devicePixelRatio;
    double _scrollNum =
        _imageGlobalKey.currentContext.size.height - viewport + padding + 80.0;

    if (_imageGlobalKey.currentContext.size.height < viewport) {
      setState(() {
        _showBottom = false;
      });
    } else {
      //监听滚动事件，打印滚动位置
      _scrollController.addListener(() {
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
  }

  Future _initDetailInfo() {
    CommonServices().getDetailInfo(widget.type, widget.id).then((res) {
      if (res.statusCode == 200) {
        DetailModel _bean = DetailModel.fromJson(res.data);
        if (_bean.status == "success") {
          setState(() {
            _detail = _bean.response;
          });
        }
      }
    });
  }

  Widget _imageList(BuildContext context) {
    double deviceWidth = window.physicalSize.height / window.devicePixelRatio;
    List<Widget> list = [];
    Widget content;

    for (var imgs in this._detail.first.metadata.pages) {
      list.add(Container(
          width: double.infinity,
          height: this._detail.first.height *
              deviceWidth /
              this._detail.first.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              image: DecorationImage(
                  image: NetworkImage(imgs.image_urls.medium),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0)
              ])));
    }

    content = Column(key: _imageGlobalKey, children: list);
    return content;
  }

  Widget _imageInfo() {
    return Stack(
      children: <Widget>[
        Container(
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              _imageList(context),
              Container(
                height: 80.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                color: Colors.yellow,
                child: Row(children: <Widget>[
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
                ]),
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
              // duration: Duration(milliseconds: 300),
              opacity: _showBottom ? 1.0 : 0.0,
              child: Container(
                height: 80.0,
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
            body: _detail != null
                ? _imageInfo()
                : Center(
                    child:
                        SpinKitChasingDots(color: Colors.orange, size: 50.0))));
  }
}
