import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/model/post.dart';

class AddPostController extends GetxController {
  late HistoryController _historyController = Get.find();
  int capacity = 0;
  int luggage = 0;

  void changeCapacity(int capacity) {
    this.capacity = capacity;
    update();
  }

  void changeLuggage(int luggage) {
    this.luggage = luggage;
    update();
  }

  Future<http.Response> fetchAddPost({required Post post}) async {
    var addPostUrl = "http://walab.handong.edu:8080/itaxi/api/";
    addPostUrl = '${addPostUrl}post';

    var body = utf8.encode(json.encode(post.toAddPostMap()));

    http.Response response = await http.post(
      Uri.parse(addPostUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    print(response.body);
    if (response.statusCode == 200) {
      _historyController.getHistorys();
      return response;
    } else {
      throw Exception('Failed to add posts');
    }
  }
}
