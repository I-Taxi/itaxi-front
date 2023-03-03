import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:itaxi/history/controller/historyController.dart';
import 'package:itaxi/ip/controller/ipController.dart';
import 'package:itaxi/post/model/post.dart';
import 'package:itaxi/chat/repository/chatRepository.dart';

class AddPostController extends GetxController {
  late HistoryController _historyController = Get.put(HistoryController());
  IpController _ipController = Get.find();
  int capacity = 1;
  int luggage = 0;
  bool loaded = true;

  void increaseCapacity(int capacity) {
    this.capacity = capacity++;
    update();
  }

  void decreaseCapacity(int capacity) {
    this.capacity = capacity--;
    update();
  }

  void changeLuggage(int luggage) {
    this.luggage = luggage;
    update();
  }

  void unloaded() {
    loaded = false;
    update();
  }

  void completeLoad() {
    loaded = true;
    update();
  }

  Future<http.Response> fetchAddPost({required Post post}) async {
    unloaded();
    var addPostUrl = _ipController.ip.toString();
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
      Post result = Post.fromPostAllDocs(json.decode(utf8.decode(response.bodyBytes)));
      post = post.copyWith(id: result.id, joiners: result.joiners);
      await ChatRepository().setPost(post: post);
      await _historyController.getHistorys();
      completeLoad();
      return response;
    } else {
      completeLoad();
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to add posts');
    }
  }
}
