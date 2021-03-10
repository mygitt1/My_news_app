import 'package:flutter/material.dart';
import 'package:riafy/api/get_data.dart';
import 'package:riafy/widgets/single_post_widget.dart';


class UserFeed extends StatefulWidget {
  final List<String> bookmarkedItems;

  UserFeed({this.bookmarkedItems});

  @override
  _UserFeedState createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  GetApiData _getApiData = GetApiData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getApiData.getPostsData(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return SinglePostWidget(
                  postData: snapshot.data[index],
                  bookMarked: widget.bookmarkedItems
                      .contains(snapshot.data[index]["id"]),
                );
              });
        }
      },
    );
  }

}
