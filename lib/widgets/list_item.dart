import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  final IconData icon;
  final String itemName;
  final Function click;

  ListItem(this.icon, this.itemName, this.click);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.0),
      child: GestureDetector(
        onTap: widget.click,
        child: Row(children: <Widget>[
          Icon(widget.icon, color: Color(0xFF778899), size: 25.0),
          SizedBox(width: 30.0),
          Text(widget.itemName, style: TextStyle(fontSize: 14.0))
        ]),
      ),
    );
  }
}
