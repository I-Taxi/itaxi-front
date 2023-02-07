import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:itaxi/controller/chatRoomController.dart';
import 'package:itaxi/controller/dateController.dart';
import 'package:itaxi/controller/userController.dart';
import 'package:itaxi/repository/chatRepository.dart';
import 'package:itaxi/model/ktxPost.dart';
import 'package:itaxi/model/joiner.dart';

class KtxPostController extends GetxController {
  late DateController _dateController = Get.find();
  late UserController _userController = Get.find();
  late ChatRoomController _chatRoomController = Get.put(ChatRoomController());
  late Future<List<KtxPost>> posts;
  bool isLoading = true;

  List<KtxPost> ktxPostsfromJson(json) {
    List<KtxPost> result = [];
    json.forEach((item) {
      result.add(KtxPost.fromPostAllDocs(item));
    });

    return result;
  }

  Future<void> getPosts(
      {int? depId,
      int? dstId,
      required String time,}) async {
    posts = fetchPost(
      depId: depId,
      dstId: dstId,
      time: time,
    );
    isLoading = false;
    update();
  }

  // Posts 데이터 가져오기
  Future<List<KtxPost>> fetchPost(
      {int? depId, int? dstId, required String time}) async {
    var postUrl = dotenv.env['API_URL'].toString();
    final Map<String, dynamic> queryParameters;
    if ((depId == null || depId == -1) && (dstId == null || dstId == -1)) {
      queryParameters = {
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else if (depId != null && (dstId == null || dstId == -1)) {
      queryParameters = {
        'depId': depId.toString(),
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else if ((depId == null || depId == -1) && dstId != null) {
      queryParameters = {
        'dstId': dstId.toString(),
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    } else {
      queryParameters = {
        'depId': depId.toString(),
        'dstId': dstId.toString(),
        'time': DateFormat('yyyy-MM-dd').format(DateTime.parse(time)),
      };
    }
    String queryString = Uri(queryParameters: queryParameters).query;

    postUrl = '${postUrl}ktx?$queryString';

    http.Response response = await http.get(
      Uri.parse(postUrl),
      headers: <String, String>{
        'Content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return ktxPostsfromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // /itaxi/api/post/{postId}/join
  Future<void> fetchJoin({required KtxPost ktxPost}) async {
    var joinUrl = dotenv.env['API_URL'].toString();
    joinUrl = '${joinUrl}ktx/${ktxPost.id}/join';

    Map<String, dynamic> map = {
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
      KtxPost result = KtxPost.fromDocs(json.decode(utf8.decode(response.bodyBytes)));
      // await _chatRoomController.joinChat(post: result);
      // await ChatRepository().setPost(post: result);
      print('join');
    } else {
      throw Exception('Failed to join');
    }
  }

  Future<void> fetchOutJoin({required KtxPost post}) async {
    var joinUrl = dotenv.env['API_URL'].toString();
    joinUrl = '${joinUrl}ktx/${post.id}/join';
    Joiner? owner;

    post.joiners?.forEach((joiner) {
      if (joiner.owner!) {
        owner = joiner;
      }
      post.joiners?.remove(joiner);
    });

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
      print(response.body);
      // await _chatRoomController.outChat(post: post);
      // ChatRepository().setPost(post: post);

      // _chatRoomController.changeOwnerChat(ownerName: response.body);
      // if (_userController.memberId == owner?.memberId) {
      //   _chatRoomController.changeOwnerChat(post: post);
      // }
    } else {
      throw Exception('Failed to out');
    }
  }
}
