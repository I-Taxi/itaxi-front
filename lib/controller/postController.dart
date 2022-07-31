import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/model/post.dart';

class PostController extends GetxController {
  late DateController _dateController = Get.find();
  late Future<List<Post>> posts;
  bool isLoading = true;

  List<Post> PostsfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromDocs(item));
    });

    return result;
  }

  Future<void> getPosts({int? depId, int? dstId, required String time}) async {
    posts = fetchPost(time: time);
    isLoading = false;
    update();
  }

  // Posts 데이터 가져오기
  Future<List<Post>> fetchPost(
      {int? depId, int? dstId, required String time}) async {
    //?dep=${dep}&dst=${dst}&time=${time}
    var postUrl = "http://walab.handong.edu:8080/itaxi/api/";
    final queryParameters;
    if (depId == null && dstId == null) {
      queryParameters = {
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else if (depId != null && dstId == null) {
      queryParameters = {
        'depId': depId,
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else if (depId == null && dstId != null) {
      queryParameters = {
        'dstId': dstId,
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else {
      queryParameters = {
        'depId': depId,
        'dstId': dstId,
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    }

    String queryString = Uri(queryParameters: queryParameters).query;

    postUrl = postUrl + 'post?' + queryString;
    // postUrl = postUrl + 'post/all';
    http.Response response = await http.get(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    print(response.body);
    if (response.statusCode == 200) {
      return PostsfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // /itaxi/api/post/{postId}/join
  Future<void> fetchJoin({required int postId, required int luggage}) async {
    var joinUrl = "http://walab.handong.edu:8080/itaxi/api/";
    // final queryParameters = {
    //   'postId': postId.toString(),
    // };
    // String queryString = Uri(queryParameters: queryParameters).query;

    joinUrl = joinUrl + 'post/' + '$postId' + '/join';

    Map<String, dynamic> map = {
      'luggage': luggage,
      'status': 0,
      'uid': 'neo_uid',
    };

    var body = utf8.encode(json.encode(map));

    print(joinUrl);

    http.Response response = await http.post(
      Uri.parse(joinUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    print(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print(Post.fromDocs(json.decode(utf8.decode(response.bodyBytes))));
    } else {
      throw Exception('Failed to join');
    }
  }

  Future<void> fetchOutJoin({required int postId}) async {
    var joinUrl = "http://walab.handong.edu:8080/itaxi/api/";

    joinUrl = joinUrl + 'post/' + '$postId' + '/join';

    Map<String, dynamic> map = {
      'uid': 'neo_uid',
    };

    var body = utf8.encode(json.encode(map));

    print(joinUrl);

    http.Response response = await http.put(
      Uri.parse(joinUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to out');
    }
  }
}
