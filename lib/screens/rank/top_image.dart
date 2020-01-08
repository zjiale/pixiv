import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pixiv/api/CommonServices.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/illust_rank_model.dart';
import 'package:pixiv/screens/rank/rank_list_repository.dart';

class TopImage extends StatefulWidget {
  final String rankType;
  TopImage(this.rankType);

  @override
  _TopImageState createState() => _TopImageState();
}

class _TopImageState extends State<TopImage> {
  RankListRepository rankListRepository;
  Map<String, String> headers = Config.headers;
  List _source;

  @override
  void initState() {
    super.initState();
    _getImageList();
  }

  void _getImageList() {
    CommonServices().getRanking(widget.rankType, 1).then((res) {
      if (res.statusCode == 200) {
        IllustRankModel _bean = IllustRankModel.fromJson(res.data);
        if (_bean.status == "success") {
          rankListRepository = new RankListRepository(
              widget.rankType, _bean.response.first.works, true);
          setState(() {
            _source = _bean.response.first.works;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    rankListRepository?.dispose();
    super.dispose();
  }

  Widget topImageList(int index) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.black45, offset: Offset(0.0, 2.0), blurRadius: 6.0)
        ]),
        child: Column(
          children: <Widget>[
            Container(
                height: _source[index].work.height *
                    deviceWidth /
                    _source[index].work.width,
                // width: double.infinity,
                child: ExtendedImage.network(
                    _source[index].work.image_urls.px_480mw,
                    headers: headers,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter)),
            Container(
              height: ScreenUtil().setHeight(100.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(3.0),
                      bottomLeft: Radius.circular(3.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: <
                      Widget>[
                    CircleAvatar(
                        radius: 18.0,
                        backgroundImage: ExtendedNetworkImageProvider(
                          _source[index].work.user.profile_image_urls.px_50x50,
                          headers: headers,
                        )),
                    SizedBox(width: 5.0),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_source[index].work.title,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(_source[index].work.user.name,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 13.0))
                        ])
                  ]),
                  Row(
                    children: <Widget>[
                      LikeButton(likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.grey,
                          size: 25.0,
                        );
                      }),
                      SizedBox(width: 10.0),
                      LikeButton(
                        size: 20.0,
                        circleColor: CircleColor(
                            start: Color(0xff00ddff), end: Color(0xff0099cc)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xff33b5e5),
                          dotSecondaryColor: Color(0xff0099cc),
                        ),
                        likeBuilder: (bool isLiked) {
                          return Icon(
                            FontAwesomeIcons.download,
                            color:
                                isLiked ? Colors.deepPurpleAccent : Colors.grey,
                            size: 20.0,
                          );
                        },
                        onTap: (bool isLiked) {
                          showDialog(
                              // 设置点击 dialog 外部不取消 dialog，默认能够取消
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text('选择分辨率下载'),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Image.asset('assets/images/low.png',
                                              width: 30.0, height: 30.0),
                                          Image.asset(
                                              'assets/images/middle.png',
                                              width: 30.0,
                                              height: 30.0),
                                          Image.asset('assets/images/high.png',
                                              width: 30.0, height: 30.0),
                                        ],
                                      ),
                                      backgroundColor: Colors.white,
                                      elevation: 8.0,
                                      // 投影的阴影高度
                                      semanticLabel: 'Label',
                                      // 这个用于无障碍下弹出 dialog 的提示
                                      shape: Border.all(),
                                      // dialog 的操作按钮，actions 的个数尽量控制不要过多，否则会溢出 `Overflow`
                                      actions: <Widget>[
                                        // 点击取消按钮
                                        FlatButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text('取消'))
                                      ]));
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget imageItem(BuildContext context, Works item, int index) {
    return Container(
        child: ExtendedImage.network(item.work.image_urls.px_480mw,
            headers: headers,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return _source != null
        ? LoadingMoreCustomScrollView(
            rebuildCustomScrollView: true,
            slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return topImageList(index);
                    },
                    childCount: 3,
                  ),
                ),
                LoadingMoreSliverList(SliverListConfig<Works>(
                  itemBuilder: imageItem,
                  sourceList: rankListRepository,
                  padding: EdgeInsets.all(0.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 3.0,
                    mainAxisSpacing: 3.0,
//                    childAspectRatio: 0.5
                  ),
                ))
              ])
        : SpinKitChasingDots(color: Colors.orange, size: 50.0);
  }
}
