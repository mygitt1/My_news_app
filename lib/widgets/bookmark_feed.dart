import 'package:flutter/material.dart';
import 'package:riafy/api/get_data.dart';
import 'package:riafy/widgets/single_post_widget.dart';

class BookMarkFeed extends StatefulWidget {
  final List<String> bookmarkedItems;

  BookMarkFeed({this.bookmarkedItems});

  @override
  _BookMarkFeedState createState() => _BookMarkFeedState();
}

class _BookMarkFeedState extends State<BookMarkFeed> {
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
                return widget.bookmarkedItems
                        .contains(snapshot.data[index]["id"])
                    ? SinglePostWidget(
                        postData: snapshot.data[index],
                        bookMarked: widget.bookmarkedItems
                            .contains(snapshot.data[index]["id"]),
                      )
                    : SizedBox();
              });
        }
      },
    );
  }
}
