import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/model/post.dart';
import 'package:itaxi/repository/chatRepository.dart';

class AddPostController extends GetxController {
  late HistoryController _historyController = Get.put(HistoryController());
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

  Future<int> fetchAddPost({required Post post}) async {
    var addPostUrl = dotenv.env['API_URL'].toString();
    addPostUrl = '${addPostUrl}post';

    var body = utf8.encode(json.encode(post.toAddPostMap()));

    http.Response response = await http.post(
      Uri.parse(addPostUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      Post result = Post.fromDocs(json.decode(utf8.decode(response.bodyBytes)));
      post = post.copyWith(id: result.id);
      await ChatRepository().setPost(post: post);
      await _historyController.getHistorys();
      return response.statusCode;
    } else {
      print(response.statusCode);
      throw Exception('Failed to add posts');
    }
  }
}
