import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatefulWidget {
  final double width;
  final String imageUrl;
  final bool showFullImage;

  ImageWidget({this.imageUrl, this.width, this.showFullImage});

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      // decoration: BoxDecoration(border: Border.all()),
      width: widget.width,
      child: CachedNetworkImage(
        imageUrl: widget.imageUrl,
        fit: BoxFit.contain,
        placeholder: (context, url) => Padding(
          child: Center(child: CircularProgressIndicator()),
          padding: EdgeInsets.all(20.0),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
      ),
    );
  }
}

