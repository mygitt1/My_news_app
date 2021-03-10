import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riafy/widgets/linear_progress_indicator.dart';

class UploadNewPostForm extends StatefulWidget {
  final File image;

  UploadNewPostForm({this.image});

  @override
  _UploadNewPostFormState createState() => _UploadNewPostFormState();
}

class _UploadNewPostFormState extends State<UploadNewPostForm> {
  bool isUploading = false;
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: uploadPostAppBar(),
      body: ListView(
        children: [
          isUploading ? CustomProgressIndicator() : Text(""),
          imageArea(),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          // description(),
        ],
      ),
    );
  }

  // AppBar uploadPostAppBar(){
  //   return AppBar(
  //     title: Text(
  //       "Create New Post",
  //       style: TextStyle(color: Colors.black),
  //     ),
  //     backgroundColor: Colors.white70,
  //     leading: IconButton(
  //       icon: Icon(
  //         Icons.arrow_back,
  //         color: Colors.black,
  //       ),
  //       onPressed: () => Navigator.of(context).pop(),
  //     ),
  //     actions: [
  //       FlatButton(
  //         child: Text(
  //           "Post",
  //           style: TextStyle(color: Colors.blueAccent),
  //         ),
  //         onPressed: (){},
  //       )
  //     ],
  //   );
  // }

  Container imageArea() {
    return Container(
      height: 250.0,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(widget.image),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ListTile description() {
  //   return ListTile(
  //     leading: Icon(
  //       Icons.description,
  //       size: 35,
  //       color: Colors.orange,
  //     ),
  //     title: Container(
  //       width: 250,
  //       child: TextField(
  //         controller: _descriptionController,
  //         decoration: InputDecoration(
  //           hintText: "Give Description of post",
  //           border: InputBorder.none,
  //         ),
  //       ),
  //     ),
  //   );
  // }

}
