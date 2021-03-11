import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SinglePostHeader extends StatelessWidget {
  final postData;

  SinglePostHeader({this.postData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
      ),
      title: Text(
        "${postData["channelname"]}",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: Icon(FontAwesomeIcons.ellipsisV),
    );
  }
}
