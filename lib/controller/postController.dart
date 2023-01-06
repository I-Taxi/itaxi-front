import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/model/post.dart';

class PostController extends GetxController {
  late DateController _dateController = Get.find();
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  late Future<List<Post>> posts;
  bool isLoading = true;

  List<Post> PostsfromJson(json) {
    List<Post> result = [];
    json.forEach((item) {
      result.add(Post.fromPostAllDocs(item));
    });

    return result;
  }

  Future<void> getPosts(
      {int? depId,
      int? dstId,
      required String time,
      required int postType}) async {
    posts = fetchPost(
      depId: depId,
      dstId: dstId,
      time: time,
      postType: postType,
    );
    isLoading = false;
    update();
  }

  // Posts 데이터 가져오기
  Future<List<Post>> fetchPost(
      {int? depId,
      int? dstId,
      required String time,
      required int postType}) async {
    var postUrl = dotenv.env['API_URL'].toString();
    final Map<String, dynamic> queryParameters;
    if ((depId == null || depId == -1) && (dstId == null || dstId == -1)) {
      if (postType == 0) {
        queryParameters = {
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    } else if (depId != null && (dstId == null || dstId == -1)) {
      if (postType == 0) {
        queryParameters = {
          'depId': depId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'depId': depId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    } else if ((depId == null || depId == -1) && dstId != null) {
      if (postType == 0) {
        queryParameters = {
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    } else {
      if (postType == 0) {
        queryParameters = {
          'depId': depId.toString(),
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
        };
      } else {
        queryParameters = {
          'depId': depId.toString(),
          'dstId': dstId.toString(),
          'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
          'postType': postType.toString(),
        };
      }
    }
    String queryString = Uri(queryParameters: queryParameters).query;

    postUrl = '${postUrl}post?$queryString';

    http.Response response = await http.get(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return PostsfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // /itaxi/api/post/{postId}/join
  Future<void> fetchJoin({required Post post, required int luggage}) async {
    var joinUrl = dotenv.env['API_URL'].toString();
    joinUrl = '${joinUrl}post/${post.id}/join';

    Map<String, dynamic> map = {
      'luggage': luggage,
      'status': 0,
      'uid': _userController.uid,
    };
    var body = utf8.encode(json.encode(map));

    http.Response response = await http.post(
      Uri.parse(joinUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      await _chatRoomController.joinChat(post: post);
      print('join');
    } else {
      throw Exception('Failed to join');
    }
  }

  Future<void> fetchOutJoin({required Post post}) async {
    var joinUrl = dotenv.env['API_URL'].toString();
    joinUrl = '${joinUrl}post/${post.id}/join';

    Map<String, dynamic> map = {
      'uid': _userController.uid,
    };
    var body = utf8.encode(json.encode(map));

    http.Response response = await http.put(
      Uri.parse(joinUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
      body: body,
    );
    if (response.statusCode == 200) {
      await _chatRoomController.outChat(post: post);
    } else {
      throw Exception('Failed to out');
    }
  }
}
