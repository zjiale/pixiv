import 'package:flutter/material.dart';

class SelectDownLoad extends StatefulWidget {
  @override
  _SelectDownLoadState createState() => _SelectDownLoadState();
}

class _SelectDownLoadState extends State<SelectDownLoad> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('选择分辨率下载'),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('assets/images/low.png', width: 30.0, height: 30.0),
            Image.asset('assets/images/middle.png', width: 30.0, height: 30.0),
            Image.asset('assets/images/high.png', width: 30.0, height: 30.0),
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
          FlatButton(onPressed: () => Navigator.pop(context), child: Text('取消'))
        ]);
  }
}
