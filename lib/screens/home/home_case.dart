import 'package:extended_image/extended_image.dart';
import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/material.dart';
import 'package:pixiv/common/config.dart';

class HomeCase extends StatelessWidget {
  final List _case;
  HomeCase(this._case);

  @override
  Widget build(BuildContext context) {
    Map<String, String> headers = Config.headers;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _case.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 1.2,
      ),
      itemBuilder: (context, index) {
        return Container(
          child: Stack(children: <Widget>[
            ExtendedImage.network(_case[index].thumbnailUrl,
                headers: headers,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.topCenter,
                color: Colors.black26,
                colorBlendMode: BlendMode.srcOver),
            Padding(
              padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 150.0,
                  child: Text(_case[index].title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          shadows: [
                            Shadow(
                                color: Colors.black,
                                offset: Offset(-1, -1),
                                blurRadius: 5)
                          ]),
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            )
          ]),
        );
      },
    );
  }
}
