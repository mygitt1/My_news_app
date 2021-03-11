import 'package:flutter/material.dart';
import 'package:riafy/api/get_data.dart';

class ListOfBookMarkedIds extends StatefulWidget {
  @override
  _ListOfBookMarkedIdsState createState() => _ListOfBookMarkedIdsState();
}

class _ListOfBookMarkedIdsState extends State<ListOfBookMarkedIds> {
  GetApiData _getApiData = GetApiData();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.red),
                  child: Text(
                    " Your BookMarks",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: _getApiData.getOrderIdsFromLocalStorage(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("get local data");
                // print(snapshot.data);
                List<String> allBookMarkedPosts = bookMarks(snapshot.data);
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    children: allBookMarkedPosts
                        .map((e) => ListTile(
                              title: Text(e ?? ''),
                            ))
                        .toList(),
                  ),
                );
              } else {
                print("no local data");
                return Center(
                  child: Text("No Data To Show"),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  bookMarks(Map data) {
    List<String> allTitle = [];
    data.values.toList().forEach((element) {
      allTitle.add(element["postId"]);
    });
    return allTitle;
  }
}
