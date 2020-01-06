import 'package:extended_image/extended_image.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:pixiv/common/config.dart';
import 'package:pixiv/model/illust_rank_model.dart';
import 'package:pixiv/screens/rank/rank_list_repository.dart';

class ImageListItem extends StatefulWidget {
  @override
  _ImageListItemState createState() => _ImageListItemState();
}

class _ImageListItemState extends State<ImageListItem> {
  RankListRepository rankListRepository;
  Map<String, String> headers = Config.headers;

  @override
  void initState() {
    rankListRepository = new RankListRepository();
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
        height: MediaQuery.of(context).size.height * 0.7,
        child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            color: Colors.orange,
            margin: EdgeInsets.only(bottom: 10.0),
            child: ExtendedImage.network(item.work.image_urls.px_480mw,
                headers: headers,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter)));
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Material(
        child: LoadingMoreCustomScrollView(slivers: <Widget>[
      LoadingMoreSliverList(
        SliverListConfig<Works>(
            itemBuilder: imageItem,
            sourceList: rankListRepository,
//                    showGlowLeading: false,
//                    showGlowTrailing: false,
            padding: EdgeInsets.all(0.0)),
      )
    ]));
  }
}
