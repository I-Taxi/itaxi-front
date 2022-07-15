import 'package:get/get_state_manager/get_state_manager.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:itaxi/model/post.dart';

class AddPostController extends GetxController {
  Future<http.Response> fetchAddPost({required Post post}) async {
    var addPostUrl = "http://203.252.99.211:8080/";
    addPostUrl = addPostUrl + 'post';

    var body = json.encode(post.toMap());

    http.Response response = await http.post(
      Uri.parse(addPostUrl),
      body: body,
    );

    return response;
  }
}
