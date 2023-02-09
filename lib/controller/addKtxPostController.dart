import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:itaxi/controller/historyController.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/repository/ktxChatRepository.dart';

class AddKtxPostController extends GetxController {
  late HistoryController _historyController = Get.put(HistoryController());
  int capacity = 1;
  int sale = 35;
  bool loaded = true;

  void increaseCapacity(int capacity) {
    this.capacity = capacity++;
    update();
  }

  void decreaseCapacity(int capacity) {
    this.capacity = capacity--;
    update();
  }

  void setSale(int to) {
    sale = to;
    update();
  }

  Future<int> fetchAddPost({required KtxPost ktxPost}) async {
    loaded = false;
    update();
    var addPostUrl = dotenv.env['API_URL'].toString();
    addPostUrl = '${addPostUrl}ktx';

    var body = utf8.encode(json.encode(ktxPost.toAddPostMap()));

    http.Response response = await http.post(
      Uri.parse(addPostUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      KtxPost result =
          KtxPost.fromPostAllDocs(json.decode(utf8.decode(response.bodyBytes)));
      ktxPost = ktxPost.copyWith(id: result.id, joiners: result.joiners);
      await KtxChatRepository().setPost(post: ktxPost);
      await _historyController.getHistorys();
      loaded = true;
      update();
      return response.statusCode;
    } else {
      loaded = true;
      update();
      print(response.statusCode);
      print(response.body);
      throw Exception('Failed to add posts');
    }
  }
}
