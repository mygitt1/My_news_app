import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riafy/api/get_data.dart';

class SinglePostFooter extends StatefulWidget {
  final postData;
  final Function likesCallback;
  final bool bookMarked;

  SinglePostFooter({this.postData, this.likesCallback, this.bookMarked});

  @override
  _SinglePostFooterState createState() => _SinglePostFooterState();
}

class _SinglePostFooterState extends State<SinglePostFooter> {
  bool showSeeMore = false;
  bool viewComments = false;
  GetApiData _getApiData = GetApiData();
  bool bookMarked = false;

  @override
  void initState() {
    setState(() {
      bookMarked = widget.bookMarked;
    });
    if (widget.postData["title"].length > 50) {
      setState(() {
        showSeeMore = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(padding: EdgeInsets.only(top: 40.0, left: 20.0)),
                Icon(
                  FontAwesomeIcons.heart,
                  size: 20.0,
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(right: 20.0)),
                Icon(
                  FontAwesomeIcons.comment,
                  size: 20.0,
                  color: Colors.black,
                ),
                Padding(padding: EdgeInsets.only(right: 20.0)),
                Icon(
                  FontAwesomeIcons.shareSquare,
                  size: 20.0,
                  color: Colors.black,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: Icon(
                  bookMarked
                      ? FontAwesomeIcons.solidBookmark
                      : FontAwesomeIcons.bookmark,
                  color: bookMarked ? Colors.red : Colors.black,
                ),
                onPressed: () async {
                  _getApiData.addOrderIdToLocalStorage(
                    widget.postData["id"],
                  );
                  setState(() {
                    bookMarked = true;
                  });
                },
              ),
            )
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "23 likes",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 10.0)),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: captionString(widget.postData["title"]),
        ),
        !viewComments
            ? GestureDetector(
                child: Container(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 8.0),
                    child: Text(
                      "View Comments",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                onTap: () {
                  setState(() {
                    viewComments = true;
                  });
                },
              )
            : FutureBuilder(
                future: _getApiData.getComment(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("comments");
                    print(snapshot.data.runtimeType.toString());
                    if (snapshot.data.length == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 20.0,
                        ),
                        child: Text("No Comments"),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 20.0,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: commentString(snapshot.data[0]),
                        ),
                      );
                    }
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 20.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "loading comments...",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
      ],
    );
  }

  commentString(commentData) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "${commentData["username"]}  ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: "${commentData["comments"]}",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }

  captionString(String text) {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: "${widget.postData["channelname"]}  ",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          showSeeMore
              ? TextSpan(
                  text: text.length > 50 ? '${text.substring(0, 50)}' : "$text",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                )
              : TextSpan(
                  text: "$text",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
          showSeeMore
              ? TextSpan(
                  text: '... more',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      setState(() {
                        showSeeMore = false;
                      });
                    },
                )
              : TextSpan(text: "."),
        ],
      ),
    );
  }
}
