import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/model/post.dart';

class HistoryController extends GetxController {
  late Future<List<Post>> soonHistorys;

  @override
  Future<void> onInit() async {
    super.onInit();
    soonHistorys = fetchSoonHistorys();
  }

  List<Post> HistorysfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromDocs(item));
    });

    return result;
  }

  // /itaxi/api/post/history
  Future<List<Post>> fetchSoonHistorys() async {
    var historyUrl = "http://walab.handong.edu:8080/itaxi/api/";
    // var body = json.encode({'uid': '1'});
    final queryParameters = {
      'uid': 'neo_uid',
    };
    String queryString = Uri(queryParameters: queryParameters).query;
    historyUrl += '/post/history?' + queryString;
    http.Response response = await http.get(
      Uri.parse(historyUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return HistorysfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load historys');
    }
  }
}
