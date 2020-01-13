import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixiv/common/config.dart';

class IlluserDesc extends StatelessWidget {
  final dynamic _query;
  IlluserDesc(this._query);

  // 图片简介相关属性
  final int _maxLine = 2;
  final Map<String, String> headers = Config.headers;

  @override
  Widget build(BuildContext context) {
    final List _tags = _query.tags;

    return Padding(
      padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
}
