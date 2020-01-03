import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/material.dart';
import 'package:pixiv/common/config.dart';

class HomeLatest extends StatelessWidget {
  final List _latest;
  HomeLatest(this._latest);

  @override
  Widget build(BuildContext context) {
    Map<String, String> headers = Config.headers;
    return GridView.builder(
      shrinkWrap: true,
      itemCount: _latest.length,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: ExtendedNetworkImageProvider(
                        _latest[index].image_urls.large,
                        headers: headers,
                        cache: true))));
      },
    );
  }
}
