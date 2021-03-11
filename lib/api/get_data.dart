import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetApiData {
  String url1 =
      "https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas";
  String url2 = "http://cookbookrecipes.in/test.php";

  getPostsData() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var response = await http.get(url1, headers: headers);
    print("get coobook response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result;
    }
  }

  getComment() async {
    Map<String, String> headers = {
      "Content-type": "application/json",
    };

    var response = await http.get(url2, headers: headers).whenComplete(() {
      print('commmets completed');
    }).catchError((error) {
      print('comments error');
      print(error.toString());
    });
    print("get comments response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return result;
    }
  }

  Future<Map> getOrderIdsFromLocalStorage() async {
    Map allOrdersMap;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString('orders.json');
    if (jsonString != null && jsonString.isNotEmpty) {
      allOrdersMap = json.decode(jsonString);

      return allOrdersMap;
    } else {
      return {};
    }
  }

  addOrderIdToLocalStorage(String postID) async {
    Map allOrdersMap = {};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString('orders.json');
    if (jsonString != null && jsonString.isNotEmpty) {
      allOrdersMap = json.decode(jsonString);
      bool duplicate = false;
      print(duplicate.toString());

      allOrdersMap.forEach((key, value) {
        if (allOrdersMap[key]["postId"] == postID) {
          print("same id");
          duplicate = true;
        } else {
          print("Unique Id");
        }
      });
      if (duplicate) {
        print('dublicate value found');

        return null;
      } else {
        print('New value found');

        allOrdersMap["${allOrdersMap.length + 1}"] = {
          "postId": postID,
        };
        print(allOrdersMap.toString());
        var jsonToSave = json.encode(allOrdersMap);
        await prefs.setString('orders.json', jsonToSave).whenComplete(() {
          print('completed to set');
        });
      }
    } else {
      allOrdersMap["1"] = {
        "postId": postID,
      };
      String jsonToSave = json.encode(allOrdersMap);
      await prefs.setString('orders.json', jsonToSave);
    }
  }
}
