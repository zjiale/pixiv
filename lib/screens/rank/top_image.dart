import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
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

  @override
  void initState() {
    rankListRepository = new RankListRepository(widget.rankType);
    super.initState();
  }

  @override
  void dispose() {
    rankListRepository?.dispose();
    super.dispose();
  }

  Widget imageItem(BuildContext context, Works item, int index) {
    return Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.infinity,
                child: ExtendedImage.network(item.work.image_urls.px_480mw,
                    headers: headers,
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter)),
            Container(
                height: ScreenUtil().setHeight(100.0), color: Colors.orange)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return LoadingMoreCustomScrollView(slivers: <Widget>[
      LoadingMoreSliverList(SliverListConfig<Works>(
          itemBuilder: imageItem,
          sourceList: rankListRepository,
          childCount: 2)),
      LoadingMoreList(ListConfig<Works>(
          itemBuilder: imageItem,
          sourceList: rankListRepository,
          padding: EdgeInsets.all(0.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
              mainAxisSpacing: 3.0,
              childAspectRatio: 0.5)))
    ]);
  }
}
