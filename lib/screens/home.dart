import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riafy/api/get_data.dart';
import 'package:riafy/screens/list_ids.dart';
import 'package:riafy/widgets/user_feed.dart';

double screenWidth = 0;
double screenHeight = 0;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetApiData _getApiData = GetApiData();
  int currentIndex = 0;
  Widget child;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;

    switch (currentIndex) {
      case 0:
        child = home();
        break;
      case 1:
        child = Center(
            child: Text(
          'Search',
          style: TextStyle(fontSize: 30),
        ));
        break;
      case 2:
        child = Center(
            child: Text(
          'Add',
          style: TextStyle(fontSize: 30),
        ));
        break;
      case 3:
        child = Center(
            child: Text(
          'Favourite',
          style: TextStyle(fontSize: 30),
        ));
        break;
      case 4:
        child = ListOfBookMarkedIds();
        break;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: Text(
          "Flutter Riafy",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: Icon(
          FontAwesomeIcons.camera,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.shareSquare,
              color: Colors.black,
            ),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[100],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              Icons.search_rounded,
              color: Colors.black,
            ),
            title: Text(
              "Search",
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              FontAwesomeIcons.plusSquare,
              color: Colors.black,
            ),
            title: Text(
              "Add",
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              FontAwesomeIcons.heart,
              color: Colors.black,
            ),
            title: Text(
              "Like",
              style: TextStyle(color: Colors.black),
            ),
          ),
          BottomNavigationBarItem(
            icon: new Icon(
              FontAwesomeIcons.bookmark,
              color: Colors.black,
            ),
            title: Text(
              "Bookmark",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: child,
    );
  }

  home() {
    return FutureBuilder(
      future: _getApiData.getOrderIdsFromLocalStorage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print("get local data");
          // print(snapshot.data);
          List<String> allBookMarkedPosts = bookMarks(snapshot.data);
          return UserFeed(
            bookmarkedItems: allBookMarkedPosts,
          );
        } else {
          print("no local data");
          return UserFeed(
            bookmarkedItems: [],
          );
        }
      },
    );
  }

  bookMarks(Map data) {
    List<String> allIds = [];
    data.values.toList().forEach((element) {
      allIds.add(element["postId"]);
    });
    return allIds;
  }
}
