import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetApiData {
  String url1 =
      "https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas";
  String url2 = "http://cookbookrecipes.in/test.php";

  getPostsData() async {
    // String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url1");
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    // print("session token: $sessionToken");

    var response = await http.get(url1, headers: headers);
    print("get coobook response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      // print("results $result");
      return result;
      // return result["message"];
      // return getCompaniesList(result["message"]);

      // if (result != null &&a
      //     result.containsKey('auth') &&
      //     result['auth'] == true) {
      //   Toast.show("${result['message']}", context,
      //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  getComment() async {
    // String url = GlobalInstance.apiBaseUrl + filterPath;
    print("get url: $url2");
    Map<String, String> headers = {
      "Content-type": "application/json",
    };
    // print("session token: $sessionToken");

    var response = await http.get(url2, headers: headers);
    print("get comments response: ${response.statusCode}");
    var result = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // print("ggggg");
      // print("results $result");
      return result;
      // return result["message"];
      // return getCompaniesList(result["message"]);

      // if (result != null &&a
      //     result.containsKey('auth') &&
      //     result['auth'] == true) {
      //   Toast.show("${result['message']}", context,
      //       duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      // }
    } else if (result != null &&
        result.containsKey('auth') &&
        result['auth'] != true) {
    } else {
      // Toast.show("Something went wrong!", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<Map> getOrderIdsFromLocalStorage() async {
    print("getting order details");
    Map allOrdersMap;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString('orders.json');
    if (jsonString != null && jsonString.isNotEmpty) {
      print("data present locally");
      allOrdersMap = json.decode(jsonString);
      print(allOrdersMap);
      return allOrdersMap;
    } else {
      print("No data found locally");
      return {};
    }
  }

  addOrderIdToLocalStorage(String title) async {
    Map allOrdersMap = {};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String jsonString = prefs.getString('orders.json');
    if (jsonString != null && jsonString.isNotEmpty) {
      print("adding data to already present datta locallys");
      allOrdersMap = json.decode(jsonString);
      allOrdersMap["${allOrdersMap.length + 1}"] = {
        "title": title,
      };
      var jsonToSave = json.encode(allOrdersMap);
      await prefs.setString('orders.json', jsonToSave);
    } else {
      print("adding new data locally");
      allOrdersMap["1"] = {
        "title": title,
      };
      var jsonToSave = json.encode(allOrdersMap);
      await prefs.setString('orders.json', jsonToSave);
    }
  }
}
