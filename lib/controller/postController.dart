import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/model/post.dart';

class PostController extends GetxController {
  DateController _dateController = Get.put(DateController());
  late Future<List<Post>> posts;
  bool isLoading = true;

  Future<void> getPosts({int? depId, int? dstId, required String time}) async {
    posts = fetchPost(time: time);
    isLoading = false;
    update();
  }

  // Posts 데이터 가져오기
  List<Post> PostfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromDocs(item));
    });

    return result;
  }

  Future<List<Post>> fetchPost(
      {int? depId, int? dstId, required String time}) async {
    //?dep=${dep}&dst=${dst}&time=${time}
    var postUrl = "http://walab.handong.edu:8080/itaxi/api/";
    final queryParameters = {
      'depId': depId,
      'dstId': dstId,
      'time': time,
    };
    String queryString = Uri(queryParameters: queryParameters).query;

    postUrl = postUrl + 'post?' + queryString;

    var response = await http.get(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PostfromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to load posts');
    }
  }
}
