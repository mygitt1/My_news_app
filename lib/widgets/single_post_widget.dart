import 'package:flutter/material.dart';
import 'package:riafy/screens/home.dart';
import 'package:riafy/widgets/single_post_footer.dart';
import 'package:riafy/widgets/single_post_header.dart';

import 'image_widget.dart';

class SinglePostWidget extends StatefulWidget {
  final postData;
  final bookMarked;

  SinglePostWidget({
    this.postData,
    this.bookMarked,
  });

  @override
  _SinglePostWidgetState createState() => _SinglePostWidgetState();
}

class _SinglePostWidgetState extends State<SinglePostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SinglePostHeader(postData: widget.postData),
        ImageWidget(
          width: screenWidth,
          imageUrl: widget.postData["high thumbnail"],
          showFullImage: false,
        ),
        SinglePostFooter(
          postData: widget.postData,
          bookMarked: widget.bookMarked,
        ),
        Divider(
          color: Colors.black,
        ),
      ],
    );
  }

// changeNoOfLike() async {
//   await firebaseRef
//       .document(widget.postData.postId)
//       .updateData({"likes": widget.postData.likes + 1});
// }
}
