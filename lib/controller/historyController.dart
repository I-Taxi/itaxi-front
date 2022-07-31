import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itaxi/model/post.dart';

class HistoryController extends GetxController {
  late Future<List<Post>> historys;
  late List<Post> soonHistorys;
  late List<Post> afterHistorys;

  @override
  Future<void> onInit() async {
    super.onInit();
    historys = fetchHistorys();
  }

  Future<void> splitHistorys(AsyncSnapshot<List<Post>> snapshot) async {
    for (int i = 0; i < snapshot.data!.length; i++) {
      if (DateTime.now()
              .difference(DateTime.parse(snapshot.data![i].deptTime!))
              .isNegative ==
          false) {
        afterHistorys.add(snapshot.data![i]);
      } else {
        soonHistorys.add(snapshot.data![i]);
      }
    }
    update();
  }

  List<Post> HistorysfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromDocs(item));
    });

    return result;
  }

  Future<void> getHistorys() async {
    historys = fetchHistorys();
    update();
  }

  // /itaxi/api/post/history
  Future<List<Post>> fetchHistorys() async {
    var historyUrl = "http://walab.handong.edu:8080/itaxi/api/";

    Map<String, dynamic> map = {
      'uid': 'neo_uid',
    };
    var body = utf8.encode(json.encode(map));

    historyUrl += '/post/history?';

    http.Response response = await http.post(
      Uri.parse(historyUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    print(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      return HistorysfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load historys');
    }
  }
}
